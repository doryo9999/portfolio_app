User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now,
             profile: "I like black cat.")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  profile = "I like " + Faker::Cat.breed + "."
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now,
              profile: profile)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(2)
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content, title: title) }
end


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }