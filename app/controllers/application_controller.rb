class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include WardenHelper
  include UrlHelper
end
