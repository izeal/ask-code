User.create(
    name:'Ivan',
    login:'izeal',
    email: 'foo@bar.baz',
    password: 'foobar',
    avatar_url: 'https://avatars3.githubusercontent.com/u/31633474?s=460&v=4'
)

10.times do |n|
  name = Faker::Name.name
  login = Faker::LordOfTheRings.character.gsub(" ", "_")
  avatar_url = Faker::Avatar.image
  User.create(
    name: name,
    login: login,
    avatar_url: avatar_url,
    email: "#{login}@bar.baz",
    password: 'foobar'
  )
end

users = User.all
5.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(text: content) }
end
