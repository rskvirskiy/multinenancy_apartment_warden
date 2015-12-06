require Rails.root.join('lib', 'warden_strategies', 'password_strategy')

class TenantPasswordStrategy < PasswordStrategy
  protected

  def authenticate!
    subdomain = get_subdomain

    tenant = Tenant.find_by(email: params[strategy_params_key]['email'])
    return fail! message: 'strategies.password.failed' if tenant.name != subdomain

    return success!(tenant) if tenant && tenant.authenticate(params[strategy_params_key]['password'])
    fail! message: 'strategies.password.failed'
  end

  def strategy_params_key
    'tenant'
  end

  private

  def get_subdomain
    Apartment::Elevators::Subdomain.new(nil).parse_tenant_name(request)
  end
end

Warden::Strategies.add(:tenant_password, TenantPasswordStrategy)