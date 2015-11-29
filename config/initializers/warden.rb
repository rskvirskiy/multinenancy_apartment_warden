require Rails.root.join('lib', 'warden_strategies', 'password_strategy')

Warden::Manager.serialize_into_session do |tenant|
  tenant.id
end

Warden::Manager.serialize_from_session do |id|
  Tenant.find_by(id: id)
end