class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin, only: [:show, :update, :destroy]

  # GET /admins
  def index
    @admins = Admin.all

    render json: @admins
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :mobile_number)
  end
end