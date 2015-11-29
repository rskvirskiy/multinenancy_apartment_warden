require Rails.root.join('lib', 'warden_strategies', 'password_strategy')

class UserPasswordStrategy < PasswordStrategy
  protected

  def strategy_params_key
    'user'
  end

  def strategy_model
    User
  end
end

Warden::Strategies.add(:user_password, UserPasswordStrategy)