require 'rails_helper'

describe 'Admin::Admins', :type => :request do
  let(:valid_attributes) { attributes_for(:admin) }
  let(:invalid_attributes) { attributes_for(:admin).merge(email: nil) }
  let(:admin) { create(:admin) }

  describe 'POST /api/admin/admins/sign_in' do
    let(:valid_credentials) { { email: admin.email, password: admin.password } }
    let(:invalid_credentials) { { email: admin.email, password: 'invalidpassword' } }

    describe 'with valid credentials' do
      before do
        post '/api/admin/admins/sign_in', params: valid_credentials
        @response_json = JSON.parse(response.body)
        @response_header = response.headers
      end

      it 'should receives the response status :success' do
        expect(response).to have_http_status(:success)
      end

      it 'should receives the authentication info in the header' do
        expect(@response_header['uid']).to eq(admin.email)
        expect(@response_header['client']).to_not be_empty
        expect(@response_header['expiry']).to_not be_empty
        expect(@response_header['token-type']).to_not be_empty
        expect(@response_header['access-token']).to_not be_empty
      end

      it 'should receives the user data in the body' do
        expect(@response_json['data']['admin']['id']).to eq(admin.id)
        expect(@response_json['data']['admin']['email']).to eq(admin.email)
        expect(@response_json['data']['admin']['uid']).to eq(admin.email)
      end
    end

    describe 'with invalid credentials' do
      before do
        post '/api/admin/admins/sign_in', params: invalid_credentials
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
end