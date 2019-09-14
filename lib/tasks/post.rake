namespace :post do
  desc 'TODO'
  task load: :environment do
    title = Faker::Lorem.sentence(word_count: 10)
    body = Faker::Lorem.paragraph(sentence_count: 20, supplemental: true, random_sentences_to_add: 10)
    users = User.all
    first_user = users.first
    first_user_account = first_user.accounts.first
    parent_post = Post.create(title: "Parent Title #{title}", body: "Parent Body #{body}", user_id: first_user.id, account_id: first_user_account.id)
    (1..10).each do |num|
      user = users.sample
      account = user.accounts.first
      title = Faker::Lorem.sentence(word_count: 10)
      body = Faker::Lorem.paragraph(sentence_count: 20, supplemental: true, random_sentences_to_add: 10)
      if num.even?
        Post.create(title: title, body: body, user_id: user.id, account_id: account.id, post_id: parent_post.id)
      else
        Post.create(title: title, body: body, user_id: user.id, account_id: account.id)
      end
    end
  end
end
