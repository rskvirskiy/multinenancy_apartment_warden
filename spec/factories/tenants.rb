FactoryGirl.define do
  factory :tenant do
    sequence(:email) {|n| "tenant#{n}@mail.com" }
    password 'password'
    password_confirmation 'password'
    name 'test-tenant'
  end
end