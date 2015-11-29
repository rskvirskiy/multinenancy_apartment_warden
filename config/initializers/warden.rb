require Rails.root.join('lib', 'warden_strategies', 'tenant_password_strategy')
require Rails.root.join('lib', 'warden_strategies', 'user_password_strategy')

Warden::Manager.serialize_into_session do |user|
  {id: user.id, user_type: user.class.name}
end

Warden::Manager.serialize_from_session do |user_info|
  type_of_user = user_info['user_type'].constantize

  type_of_user.find_by(id: user_info['id'])
end