class Admin::EventsController < ApplicationController
  include Paginatable
  before_action :authenticate_admin_admin!
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    events = Event.all.page(params[:page])

    render json: events, meta: paginate(events)
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: { status: 'error', errors: @event.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { status: 'error', errors: @event.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_params
    params.fetch(:event, {}).permit(:title, :description, :start_date, :end_date)
  end
end
