FactoryBot.define do
  factory :application, class: Doorkeeper::Application do
    name 'Expert Advice'
    redirect_uri 'https://dummies.com'
  end
  factory :access_token, class: Doorkeeper::AccessToken
end
