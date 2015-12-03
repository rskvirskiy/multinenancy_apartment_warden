require Rails.root.join('lib', 'validators', 'subdomain_validator')

class Tenant < ActiveRecord::Base
  after_create :create_apartment_tenant
  after_destroy :drop_apartment_tenant

  has_secure_password

  validates_presence_of :email, :name
  validates_uniqueness_of :email

  validates :name, presence: true,
            uniqueness: true,
            subdomain: true

  private

  def create_apartment_tenant
    Apartment::Tenant.create(name)
  end

  def drop_apartment_tenant
    Apartment::Tenant.drop(name)
  end
end