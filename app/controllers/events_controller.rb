class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create

    if event_params[:title].nil? || event_params[:description].nil? || event_params[:start].nil? || event_params[:end].nil?
      render :json => { error: "Information missing" }
      return
    end

    if event_params[:title].size < 5
      render :json => { error: "Title too small" }
      return
    elsif event_params[:description].size < 5
      render :json => { error: "Description too small" }
      return
    end

    begin
      # dd-MM-yyyy'T'HH:mm
      startTime = DateTime.parse(event_params[:start])
      endTime = DateTime.parse(event_params[:end])

      @event = Event.new(event_params)

      if @event.save
        render json: @event, status: :created, location: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end

    rescue Exception => e
      render json: { error: "Bad date format" }
    end

  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
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
      params.require(:event).permit(:title, :description, :start, :end)
    end
end
