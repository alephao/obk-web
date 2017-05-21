require 'rails_helper'

describe 'Admin::Dashboard', :type => :request do
  let(:admin) { create(:admin) }

  before { @auth_headers = authenticate_user(admin) }
  after { expire_token(admin, @auth_headers['client']) }

  describe 'GET /api/admin/dashboard/summary' do
    before do
      get '/api/admin/dashboard/summary', headers: @auth_headers
      @json_body = JSON.parse(response.body)
    end

    it 'should return the dashboard summary' do
      expect(@json_body.size).to eq(4)
    end

    it 'should contains dashboard summary info' do
      expect(@json_body).to include('volunteers' => 0)
      expect(@json_body).to include('upcoming_events' => 0)
      expect(@json_body).to include('past_events' => 0)
      expect(@json_body).to include('volunteers_per_event' => 0)
    end
  end
end