class UsersController < ApplicationController
  before_action :current_user_tenant?
  before_action :set_schema

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "#{@user.email} was created"

      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.join(',')

      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    flash[:success] = "#{@user.email} was deleted"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def current_user_tenant?
    render status: 403, text: 'Not authorized' unless current_user_type_is_tenant?
  end

  def set_schema
    return unless current_user_type_is_tenant?

    Apartment::Tenant.switch!(current_user.name)
  end
end