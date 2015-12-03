FactoryGirl.define do
  factory :user do
    email 'user@ex.com'
    password 'password'
    password_confirmation 'password'
  end
end