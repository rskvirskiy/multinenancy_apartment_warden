require Rails.root.join('lib', 'warden_strategies', 'password_strategy')

class TenantPasswordStrategy < PasswordStrategy
  protected

  def strategy_params_key
    'tenant'
  end
end

Warden::Strategies.add(:tenant_password, TenantPasswordStrategy)