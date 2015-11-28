class Tenant < ActiveRecord::Base
  validates_presence_of :email, :name

  has_secure_password
end