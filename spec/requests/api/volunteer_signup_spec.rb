require 'rails_helper'

describe 'Volunteer sign up', :type => :request do
  let(:valid_attributes) { attributes_for(:volunteer) }
  let(:invalid_attributes) { attributes_for(:volunteer).merge(email: nil) }

  describe 'POST /api/auth' do

    describe 'with valid params' do
      it 'creates a new volunteer' do
        expect { post '/api/auth', params: valid_attributes }.to change(Volunteer, :count).by(1)
      end

      it 'should get the response status :success and the status: success' do
        post '/api/auth', params: valid_attributes
        expect(response).to have_http_status(:success)

        response_json = JSON.parse(response.body)

        expect(response_json).to include('status' => 'success')
      end

      it 'should receives the user data in the body' do
        post '/api/auth', params: valid_attributes

        response_json = JSON.parse(response.body)

        expect(response_json['data']['id'].to_s).to_not be_empty
        expect(response_json['data']['uid']).to eq(valid_attributes[:email])
        expect(response_json['data']['email']).to eq(valid_attributes[:email])
        expect(response_json['data']['first_name']).to eq(valid_attributes[:first_name])
        expect(response_json['data']['last_name']).to eq(valid_attributes[:last_name])
      end

      it 'should receives the authentication info in the header' do
        post '/api/auth', params: valid_attributes

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
        expect { post '/api/auth', params: invalid_attributes }.to change(Volunteer, :count).by(0)
      end

      it 'should get the response status :unprocessable_entity and the status: error' do
        post '/api/auth', params: invalid_attributes

        response_json = JSON.parse(response.body)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json).to include('status' => 'error')
      end

      it 'should validation errors' do
        post '/api/auth', params: invalid_attributes

        response_json = JSON.parse(response.body)

        expect(response_json['errors']['email']).to include('can\'t be blank', 'is not an email')
        expect(response_json['errors']['full_messages']).to include('Email can\'t be blank', 'Email is not an email')
      end
    end
  end
end