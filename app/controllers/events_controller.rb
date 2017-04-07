class EventsController < ApplicationController
  include Paginatable
  before_action :authenticate_volunteer!, except: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy, :join]

  # GET /events
  def index
    events = Event.upcoming.page(params[:page])

    if current_volunteer
      volunteer_events = current_volunteer.events
      events.each do |ev|
        ev.going! if volunteer_events.include?(ev)
      end
    end

    render json: events, meta: paginate(events)
  end

  # GET /events/1
  def show
    render json: @event
  end

  # PUT /events
  def join
    if @event.volunteers.include?(current_volunteer)
      return render json: { status: 'error', errors: [I18n.t(:volunteer_already_joined)] }, status: :unprocessable_entity
    end

    begin
      Event.transaction do
        @event.volunteers << current_volunteer
        @event.validate!
      end

      render status: :ok
    rescue ActiveRecord::RecordInvalid => invalid_error
      render json: { status: 'error', errors: invalid_error.record.errors }, status: :unprocessable_entity
    rescue StandardError => error
      logger.debug("Volunteer #{current_volunteer.id} tried joining to #{@event.id} and failed")
      logger.error(error)
      render status: :internal_server_error
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.require(:event).permit(:title, :description, :start, :end)
  end
end
