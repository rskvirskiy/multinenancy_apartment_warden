class TenantMiddleware < Apartment::Elevators::Subdomain
  def call(env)
    begin
      super
    rescue Apartment::TenantNotFound => e
      debugger
      domain_subdomain = domain_subdomain(env['HTTP_HOST'])

      set_error_message_in_flash(env, domain_subdomain[:subdomain])

      location = root_url(domain_subdomain[:domain])
      return [301, {'Location' => location}, ['redirect']]
    end
  end

  private

  def set_error_message_in_flash(env, subdomain)
    request = ActionDispatch::Request.new(env)
    request.flash['danger'] = "Subdomain '#{subdomain}' does not exist."
  end

  def root_url(host)
    Rails.application.routes.url_helpers.root_url(host: host)
  end

  def domain_subdomain(host)
    partitioned = host.partition '.'

    {domain: partitioned.last, subdomain: partitioned.first}
  end
end