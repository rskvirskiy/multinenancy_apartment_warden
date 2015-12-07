class SessionsController < ApplicationController
  skip_before_action :authenticate!
  before_action :logout, except: :new

  def new

  end

  def create
    authenticate!

    redirect_to :root
  end

  def destroy
    Apartment::Tenant.switch!('public')

    redirect_to :root
  end

  private

  def logout
    warden.logout
  end
end