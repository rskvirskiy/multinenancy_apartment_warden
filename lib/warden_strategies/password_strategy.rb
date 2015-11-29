class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?

    p 'a'*100
    p strategy_params_key
    p params

    tenant_data = params[strategy_params_key] || {}
    tenant_data['email'].present? && tenant_data['password'].present?
  end

  def authenticate!
    tenant = strategy_model.find_by(email: params[strategy_params_key]['email'])
    return success!(tenant) if tenant && tenant.authenticate(params[strategy_params_key]['password'])

    fail! message: 'strategies.password.failed'
  end

  protected

  def strategy_params_key
    'session'
  end

  def strategy_model
    Tenant
  end
end
