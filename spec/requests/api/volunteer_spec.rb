require 'rails_helper'

describe 'Volunteer', :type => :request do
  let(:valid_attributes) { attributes_for(:volunteer) }
  let(:invalid_attributes) { attributes_for(:volunteer).merge(email: nil) }
  let(:volunteer) { create(:volunteer) }

  describe 'POST /api/volunteers/sign_up' do
    describe 'with valid params' do
      it 'creates a new volunteer' do
        expect { post '/api/volunteers/sign_up', params: valid_attributes }.to change(Volunteer, :count).by(1)
      end

      it 'should get the response status :success and the status: success' do
        post '/api/volunteers/sign_up', params: valid_attributes
        expect(response).to have_http_status(:success)

        response_json = JSON.parse(response.body)

        expect(response_json).to include('status' => 'success')
      end

      it 'should receives the user data in the body' do
        post '/api/volunteers/sign_up', params: valid_attributes

        response_json = JSON.parse(response.body)

        expect(response_json['data']['volunteer']['id'].to_s).to_not be_empty
        expect(response_json['data']['volunteer']['uid']).to eq(valid_attributes[:email])
        expect(response_json['data']['volunteer']['email']).to eq(valid_attributes[:email])
        expect(response_json['data']['volunteer']['first_name']).to eq(valid_attributes[:first_name])
        expect(response_json['data']['volunteer']['last_name']).to eq(valid_attributes[:last_name])
      end

      it 'should receives the authentication info in the header' do
        post '/api/volunteers/sign_up', params: valid_attributes

        response_header = response.headers

        expect(response_header['uid']).to eq(valid_attributes[:email])
        expect(response_header['client']).to_not be_empty
        expect(response_header['expiry']).to_not be_empty
        expect(response_header['token-type']).to_not be_empty
        expect(response_header['access-token']).to_not be_empty
      end
    end

    describe 'with invalid params' do
      it 'shound not create a new volunteer' do
        expect { post '/api/volunteers/sign_up', params: invalid_attributes }.to change(Volunteer, :count).by(0)
      end

      it 'should get the response status :unprocessable_entity and the status: error' do
        post '/api/volunteers/sign_up', params: invalid_attributes

        response_json = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json).to include('status' => 'error')
      end

      it 'should validation errors' do
        post '/api/volunteers/sign_up', params: invalid_attributes

        response_json = JSON.parse(response.body)

        expect(response_json['errors']['email']).to include('can\'t be blank', 'is not an email')
        expect(response_json['errors']['full_messages']).to include('Email can\'t be blank', 'Email is not an email')
      end
    end
  end

  describe 'POST /api/volunteers/sign_in' do
    let(:valid_credentials) { { email: volunteer.email, password: volunteer.password } }
    let(:invalid_credentials) { { email: volunteer.email, password: 'invalidpassword' } }

    describe 'with valid credentials' do
      before do
        post '/api/volunteers/sign_in', params: valid_credentials
        @response_json = JSON.parse(response.body)
        @response_header = response.headers
      end

      it 'should receives the response status :success' do
        expect(response).to have_http_status(:success)
      end

      it 'should receives the authentication info in the header' do
        expect(@response_header['uid']).to eq(volunteer.email)
        expect(@response_header['client']).to_not be_empty
        expect(@response_header['expiry']).to_not be_empty
        expect(@response_header['token-type']).to_not be_empty
        expect(@response_header['access-token']).to_not be_empty
      end

      it 'should receives the user data in the body' do
        expect(@response_json['data']['volunteer']['id']).to eq(volunteer.id)
        expect(@response_json['data']['volunteer']['email']).to eq(volunteer.email)
        expect(@response_json['data']['volunteer']['uid']).to eq(volunteer.email)
      end
    end

    describe 'with invalid credentials' do
      before do
        post '/api/volunteers/sign_in', params: invalid_credentials
        @response_json = JSON.parse(response.body)
        @response_header = response.headers
      end

      it 'should receives the response status :unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should contains errors in the response body' do
        expect(@response_json).to have_key('errors')
      end

      it 'should contains one error' do
        expect(@response_json['errors'].size).to eq(1)
        expect(@response_json['errors'].first).to eq('Invalid login credentials. Please try again.')
      end
    end
  end

  describe 'Profile' do
    let(:volunteers_restricted_fields) { %w(id first_name last_name email mobile_number landline_number dob wwccn sub_newsletter uid) }

    before { @auth_headers = authenticate_user(volunteer) }
    after { expire_token(volunteer, @auth_headers['client']) }

    describe 'GET /api/volunteers/:id/profile' do
      describe 'with valid authenticated user' do
        before do
          get "/api/volunteers/#{volunteer.id}/profile", headers: @auth_headers
        end

        it 'should get the response status :success' do
          expect(response).to have_http_status(:success)
        end

        it 'should get volunteers profile with restricted fields' do
          response_json = JSON.parse(response.body)
          expect(response_json['volunteer'].keys - volunteers_restricted_fields). to be_empty
        end
      end

      describe 'without valid authenticated user' do
        it 'should get the response status :unauthorized' do
          get "/api/volunteers/#{volunteer.id}/profile"
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe 'PUT /api/volunteers/:id' do
      describe 'with valid params' do
        let(:new_attributes) { { first_name: "#{valid_attributes[:first_name]} [changed]" } }

        before do
          put "/api/volunteers/#{volunteer.id}", params: { volunteer: new_attributes }, headers: @auth_headers
        end

        it 'should get the response status :ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'should get the volunteer updated' do
          response_json = JSON.parse(response.body)
          expect(response_json['volunteer']['first_name']).to eq(new_attributes[:first_name])
        end
      end

      describe 'with invalid params' do
        let(:new_attributes) { { email: nil } }

        before do
          put "/api/volunteers/#{volunteer.id}", params: { volunteer: new_attributes }, headers: @auth_headers
          @response_json = JSON.parse(response.body)
        end

        it 'should get the response status :unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
          expect(@response_json).to include('status' => 'error')
        end

        it 'should contains one error' do
          expect(@response_json['errors']['email']).to include('can\'t be blank')
        end
      end
    end
  end
end