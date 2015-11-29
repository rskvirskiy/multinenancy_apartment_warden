FactoryGirl.define do
  factory :tenant do
    email 'test@ex.com'
    password 'password'
    password_confirmation 'password'
    name 'test_tenant'
  end
end