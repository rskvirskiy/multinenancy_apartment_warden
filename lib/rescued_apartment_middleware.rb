class TenantMiddleware < Apartment::Elevators::Subdomain
  def call(env)
    begin
      super
    rescue Apartment::TenantNotFound
      domain_subdomain = domain_subdomain(env['HTTP_HOST'])

      set_error_message_in_flash(env)

      location = root_url(domain_subdomain[:domain])
      return [301, {'Location' => location}, ['redirect']]
    end
  end

  private

  def set_error_message_in_flash(env)
    request = ActionDispatch::Request.new(env)
    request.flash['danger'] = 'You are not authorized to access that subdomain.'
  end

  def root_url(host)
    Rails.application.routes.url_helpers.root_url(host: host)
  end

  def domain_subdomain(host)
    partitioned = host.partition '.'

    {domain: partitioned.last, subdomain: partitioned.first}
  end
end