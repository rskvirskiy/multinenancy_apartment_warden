class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_subdomain

  include WardenHelper
  include UrlHelper

  def check_subdomain
    return if request.subdomain.empty? || request.subdomain == 'public'

    if signed_in? && current_user_type_is_tenant? && request.subdomain != current_user.name
      flash[:danger] = 'You are not authorized to access that subdomain.'
      redirect_to root_url(subdomain: current_user.name)
    end
  end
end
