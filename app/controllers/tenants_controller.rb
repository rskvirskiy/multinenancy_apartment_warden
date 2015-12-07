class TenantsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      flash[:success] = "Tenant #{@tenant.email} was created"

      set_user(@tenant)

      redirect_to root_url(subdomain: @tenant.name)
    else
      flash[:danger] = @tenant.errors.full_messages.join(', ')

      render :new
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:password, :password_confirmation, :name, :email)
  end
end