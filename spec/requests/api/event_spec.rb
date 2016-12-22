require 'rails_helper'

describe 'Event', :type => :request do
  let(:volunteer) { create(:volunteer) }
  let(:future_lunch_at_noon) { create(:future_lunch_at_noon) }

  before { @auth_headers = authenticate_user(volunteer) }
  after { expire_token(volunteer, @auth_headers['client']) }

  describe 'GET /api/events' do
    RSpec.shared_examples 'list all upcoming events' do |auth_headers = {}|
      before do
        create_list(:future_lunch_at_noon, 5)
        create_list(:event_past, 3)

        get '/api/events', headers: auth_headers
        @json_body = JSON.parse(response.body)
      end

      it 'should list only upcoming events' do
        expect(@json_body['events'].size).to eq(5)

        dates = @json_body['events'].map { |event| Time.zone.parse(event['start_date']) }

        expect(dates).to all(be >= Time.zone.now)
      end

      it 'should have pagination meta' do
        expect(@json_body['meta']).to include('current_page' => 1)
        expect(@json_body['meta']).to include('next_page' => nil)
        expect(@json_body['meta']).to include('prev_page' => nil)
        expect(@json_body['meta']).to include('total_pages' => 1)
        expect(@json_body['meta']).to include('total_count' => 5)
      end
    end

    describe 'with authenticated volunteer' do
      include_examples 'list all upcoming events', @auth_headers
    end

    describe 'with unauthenticated volunteer' do
      include_examples 'list all upcoming events'
    end
  end

  describe 'PUT /api/events/:id/join' do
    describe 'with authenticated volunteer' do
      it 'should increment the number of volunteers' do
        expect do
          put "/api/events/#{future_lunch_at_noon.id}/join", headers: @auth_headers
        end.to change { future_lunch_at_noon.volunteers .count }.by(1)
      end

      it 'should get the response status :ok' do
        put "/api/events/#{future_lunch_at_noon.id}/join", headers: @auth_headers
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'with an event already joined' do
      let(:future_lunch_at_noon) { create(:future_lunch_at_noon) }

      before do
        future_lunch_at_noon.volunteers << volunteer
        put "/api/events/#{future_lunch_at_noon.id}/join", headers: @auth_headers
      end

      it 'should get the response status :no_content' do
        expect(response).to have_http_status(:no_content)
      end

      it 'should count the volunteer again' do
        future_lunch_at_noon.reload
        expect(future_lunch_at_noon.volunteers.size).to eq(1)
      end
    end

    describe 'with no authentication' do
      before do
        put "/api/events/#{future_lunch_at_noon.id}/join"
      end

      it 'should get the response status :unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'should contains error in the response body' do
        json_body = JSON.parse(response.body)
        expect(json_body).to have_key('errors')
        expect(json_body['errors'].size).to eq(1)
        expect(json_body['errors'].first).to eq('Authorized users only.')
      end
    end

    describe 'with a past event' do
      let(:past_event) { create(:event_past) }

      before do
        put "/api/events/#{past_event.id}/join", headers: @auth_headers
        @response_json = JSON.parse(response.body)
      end

      it 'should get the response status :unprocessable_entity and has status => error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(@response_json).to include('status' => 'error')
      end

      it 'should contains one error' do
        expect(@response_json['errors'].size).to eq(1)
        expect(@response_json['errors']['start_date']).to include('can\'t be in the past')
      end

      it 'should not add the volunteer' do
        past_event.reload
        expect(past_event.volunteers.size).to eq(0)
      end
    end
  end
end