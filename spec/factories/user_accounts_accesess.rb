FactoryBot.define do
  factory :user_account_access do
    user
    account
    access_type {0}
  end
end
