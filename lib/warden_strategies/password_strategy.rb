class PasswordStrategy < ::Warden::Strategies::Base
  def valid?
    return false if request.get?

    tenant_data = params['session'] || {}
    tenant_data['email'].present? && tenant_data['password'].present?
  end

  def authenticate!
    tenant = Tenant.find_by(email: params['session']['email'])
    return success!(tenant) if tenant && tenant.authenticate(params['session']['password'])

    fail! message: 'strategies.password.failed'
  end
end

Warden::Strategies.add(:password, PasswordStrategy)