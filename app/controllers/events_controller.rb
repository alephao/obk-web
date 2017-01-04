class EventsController < ApplicationController
  include Paginatable
  before_action :authenticate_volunteer!, except: [:index, :show]
  before_action :set_event, only: [:show, :update, :destroy, :join]

  # GET /events
  def index
    events = Event.upcoming.page(params[:page])

    render json: events, meta: paginate(events)
  end

  # GET /events/1
  def show
    render json: @event
  end

  # PUT /events
  def join
    return render status: :no_content if @event.volunteers.include?(current_volunteer)

    begin
      Event.transaction do
        @event.volunteers << current_volunteer
        @event.validate!
      end

      render status: :ok
    rescue ActiveRecord::RecordInvalid => invalid_error
      render json: { status: 'error', errors: invalid_error.record.errors }, status: :unprocessable_entity
    rescue StandardError => error
      logger.debug("Volunteer #{current_volunteer.id} tried join to #{@event.id} and failed")
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
