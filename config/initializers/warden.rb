require Rails.root.join('lib', 'warden_strategies', 'tenant_password_strategy')
require Rails.root.join('lib', 'warden_strategies', 'user_password_strategy')
require Rails.root.join('lib', 'warden_manager_utilities')

Warden::Manager.serialize_into_session do |user|
  {id: user.id, is_tenant?: user.is_a?(Tenant)}
end

Warden::Manager.serialize_from_session do |user_info|
  session_serializer = WardenManagerUtilities.new(env, user_info)

  user_info['is_tenant?'] ? session_serializer.tenant : session_serializer.user
end