def find_hashtag_in(model)
  model.text.scan(/#\p{L}+/i).each do |hashtag|
    model.hashtags.create!(tag: hashtag)
  end
end

User.create(
    name:'Ivan',
    login:'izeal',
    email: 'foo@bar.baz',
    password: 'foobar',
    avatar_url: 'https://avatars3.githubusercontent.com/u/31633474?s=460&v=4'
)

puts
5.times do |n|
  name = Faker::Name.name
  login = Faker::LordOfTheRings.unique.character.gsub(" ", "_")
  avatar_url = Faker::Avatar.image
  header_background_color = Faker::Color.hex_color
  User.create(
    name: name,
    login: "#{login}",
    avatar_url: avatar_url,
    header_background_color: header_background_color,
    email: "#{login}@bar.baz",
    password: 'foobar'
  )
  print '.'
end

# 100.times do |n|
#   name = Faker::Name.name
#   login = Faker::HarryPotter.unique.character.gsub(" ", "_")
#   avatar_url = Faker::Avatar.image
#   header_background_color = Faker::Color.hex_color
#   User.create(
#     name: name,
#     login: "#{login}_#{n}",
#     avatar_url: avatar_url,
#     header_background_color: header_background_color,
#     email: "#{login}#{n}@bar.baz",
#     password: 'foobar'
#   )
# end

users = User.all
puts
users.each do |user|
  2.times { user.posts.create(text: Faker::HeyArnold.quote) }
  print '.'
end

posts = Post.all
puts
posts.each do |post|
  post_text = post.text
  2.times do
    post.update(text: (post_text + " ##{post.text.split.sample} "))
    find_hashtag_in(post)
  end
  print '.'
end

puts
posts.each do |post|
  3.times do
    post.comments.create(text: Faker::Friends.quote, user_id: users.sample.id)
  end
  print '.'
end

comments = Comment.all
puts
comments.each do |comment|
  comment_text = comment.text
  2.times do
    comment.update(text: (comment_text + " ##{comment.text.split.sample} "))
    find_hashtag_in(comment)
  end
  print '.'
end
