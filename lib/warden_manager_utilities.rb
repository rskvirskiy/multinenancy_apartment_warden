class WardenManagerUtilities
  attr_reader :env, :session_hash

  def initialize(env, session_hash)
    @env, @session_hash = env, session_hash
  end

  def tenant
    Tenant.find_by(id: session_hash['id'])
  end

  def user
    User.find_by(id: session_hash['id'])
  end

  private

  def subdomain
    env["action_controller.instance"].request.subdomain
  end
end