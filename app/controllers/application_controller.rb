class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from Apartment::TenantNotFound, with: :show_errors

  include WardenHelper
  include UrlHelper

  private

  def show_errors
    debugger
  end
end
