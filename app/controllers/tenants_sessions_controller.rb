class TenantsSessionsController < SessionsController
  skip_before_action :check_subdomain, only: :create

  def create
    authenticate!

    redirect_to root_url(subdomain: current_user.name)
  end
end