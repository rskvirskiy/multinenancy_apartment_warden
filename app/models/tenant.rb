class Tenant < ActiveRecord::Base
  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_secure_password
end