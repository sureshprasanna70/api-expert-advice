namespace :user do
  task load: :environment do
    (1..10).each do |_num|
      user = User.new(email: Faker::Internet.email, password: '12345678', password_confirmation: '12345678')
      user.accounts.build
      user.save!
    end
  end
end
