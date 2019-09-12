namespace :user do
  desc "TODO"
  task load: :environment do
    (1..10).each do |num|
      user = User.new(email: Faker::Internet.email,password: '12345678',password_confirmation: '12345678')
      account = user.accounts.build
      account_user = AccountUser.new(user: user, account: account)
      user.save!
    end
  end

end
