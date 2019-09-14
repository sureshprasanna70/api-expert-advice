require 'factory_bot'
FactoryBot.define do
  factory :user do
    email {'admin@gmail.com'}
    password {'1234567890'}
    password_confirmation {'1234567890'}
  end
end
