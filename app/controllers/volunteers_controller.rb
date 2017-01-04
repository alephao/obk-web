class VolunteersController < ApplicationController
  before_action :authenticate_volunteer!
  before_action :set_volunteer, only: [:show, :profile, :update, :destroy]

  # GET /volunteers
  def index
    @volunteers = Volunteer.all.order("first_name || ' ' || last_name")

    render json: @volunteers
  end

  # GET /volunteers/1
  def show
    render json: @volunteer
  end

  # GET /volunteers/1/profile
  def profile
    render json: @volunteer, serializer: VolunteerProfileSerializer
  end

  # PATCH/PUT /volunteers/1
  def update
    if @volunteer.update(volunteer_params)
      render json: @volunteer
    else
      render json: { status: 'error', errors: @volunteer.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /volunteers/1
  def destroy
    @volunteer.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def volunteer_params
    params.require(:volunteer).permit(:first_name, :last_name, :email, :mobile_number, :gender,
                                      :landline_number, :dob, :wwccn, :sub_newsletter)
  end
end