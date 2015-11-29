class Tenant < ActiveRecord::Base
  after_create :create_apartment_tenant

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  has_secure_password

  private

  def create_apartment_tenant
    Apartment::Tenant.create(name)
  end
end