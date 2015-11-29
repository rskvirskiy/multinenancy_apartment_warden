class SessionsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @user_type = params[:for_tenant] ? 'tenant' : 'user'
  end

  def create
    authenticate!

    redirect_to :root
  end

  def destroy
    warden.logout

    redirect_to :root
  end
end