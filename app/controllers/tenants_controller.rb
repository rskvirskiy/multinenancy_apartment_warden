class TenantsController < ApplicationController
  skip_before_action :authenticate!

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      flash[:success] = "Tenant #{@tenant.email} was created"

      redirect_to root_path
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