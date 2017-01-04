require 'rails_helper'

describe 'Admin::Event', :type => :request do
  let(:admin) { create(:admin) }
  #let(:future_lunch_at_noon) { create(:future_lunch_at_noon) }

  let(:valid_attributes) { attributes_for(:future_lunch_at_noon) }
  let(:invalid_attributes) { attributes_for(:future_lunch_at_noon).merge(title: nil) }

  before { @auth_headers = authenticate_user(admin) }
  after { expire_token(admin, @auth_headers['client']) }

  describe 'GET /api/admin/events' do
    before do
      create_list(:future_lunch_at_noon, 2)
      create_list(:event_past, 2)

      get '/api/admin/events', headers: @auth_headers
      @json_body = JSON.parse(response.body)
    end

    it 'should return all events paginated' do
      expect(@json_body['events'].size).to eq(4)
    end

    it 'should contains pagination meta info' do
      expect(@json_body['meta']).to include('current_page' => 1)
      expect(@json_body['meta']).to include('next_page' => nil)
      expect(@json_body['meta']).to include('prev_page' => nil)
      expect(@json_body['meta']).to include('total_pages' => 1)
      expect(@json_body['meta']).to include('total_count' => 4)
    end
  end

  describe 'GET /api/admin/events/:id' do
    it 'should return the event' do
      event = create(:future_lunch_at_noon)
      get "/api/admin/events/#{event.to_param}", headers: @auth_headers

      json_body = JSON.parse(response.body)
      expect(json_body).to have_key('event')
      expect(json_body['event']).to_not be_empty
    end
  end

  describe 'POST /api/admin/events' do
    describe 'with valid params' do
      it 'creates a new Event' do
        expect do
          post '/api/admin/events', params: { event: valid_attributes }, headers: @auth_headers
        end.to change(Event, :count).by(1)
      end

      it 'should get the response status :created' do
        post '/api/admin/events', params: { event: valid_attributes }, headers: @auth_headers
        expect(response).to have_http_status(:created)
      end

      it 'should return the event persisted' do
        post '/api/admin/events', params: { event: valid_attributes }, headers: @auth_headers

        string_event = ActiveModelSerializers::SerializableResource.new(Event.new(valid_attributes)).to_json
        expected_event = JSON.parse(string_event)
        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('event')
        expect(json_body['event']['id']).to_not be_nil
        expect(json_body['event'].except('id')).to eq(expected_event['event'].except('id'))
      end
    end

    describe 'with invalid params' do
      before do
        post '/api/admin/events', params: { event: invalid_attributes }, headers: @auth_headers
        @response_json = JSON.parse(response.body)
      end

      it 'should get the response status :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(@response_json).to include('status' => 'error')
      end

      it 'should contains one error' do
        expect(@response_json['errors']['title']).to include('can\'t be blank')
      end
    end
  end

  describe 'PUT/PATCH /api/admin/events/:id' do
    describe 'with valid params' do
      let(:new_attributes) { { 'title' => "#{valid_attributes[:title]} [edited]" } }

      before do
        @event = Event.create! valid_attributes
        put "/api/admin/events/#{@event.to_param}", params: { event: new_attributes }, headers: @auth_headers
        @event.reload
      end

      it 'should get the response status :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'should contains the attributes updated' do
        expect(@event.attributes).to include(new_attributes)
      end

      it 'should return the event updated' do
        string_event = ActiveModelSerializers::SerializableResource.new(@event).to_json
        updated_event = JSON.parse(string_event)
        json_body = JSON.parse(response.body)

        expect(json_body).to have_key('event')
        expect(json_body['event']).to eq(updated_event['event'])
      end
    end

    describe 'with invalid params' do
      before do
        @event = Event.create! valid_attributes
        put "/api/admin/events/#{@event.to_param}", params: { event: invalid_attributes }, headers: @auth_headers
        @response_json = JSON.parse(response.body)
      end

      it 'should get the response status :unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(@response_json).to include('status' => 'error')
      end

      it 'should contains one error' do
        expect(@response_json['errors']['title']).to include('can\'t be blank')
      end
    end
  end

  describe 'DELETE /api/admin/events/:id' do
    before do
      @event = Event.create! valid_attributes
    end

    it 'destroys the requested event' do
      expect { delete "/api/admin/events/#{@event.to_param}", headers: @auth_headers }.to change(Event, :count).by(-1)
    end

    it 'should get the response status :no_content' do
      delete "/api/admin/events/#{@event.to_param}", headers: @auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end