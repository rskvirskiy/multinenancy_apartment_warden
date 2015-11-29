module WardenHelper
  extend ActiveSupport::Concern

  included do
    helper_method :warden, :signed_in?, :current_user, :current_user_type_is_tenant?

    prepend_before_action :authenticate!
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    warden.user
  end

  def current_user_type_is_tenant?
    current_user.is_a? Tenant
  end

  def current_user_type_is_user?
    current_user.is_a? User
  end

  def warden
    request.env['warden']
  end

  def authenticate!
    warden.authenticate!
  end
end