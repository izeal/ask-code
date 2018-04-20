User.create(
    name:'Ivan',
    login:'izeal',
    email: 'foo@bar.baz',
    password: 'foobar',
    avatar_url: 'https://avatars3.githubusercontent.com/u/31633474?s=460&v=4'
)

100.times do |n|
  name = Faker::Name.name
  login = Faker::LordOfTheRings.character.gsub(" ", "_")
  avatar_url = Faker::Avatar.image
  User.create(
    name: name,
    login: "#{login}_#{n}",
    avatar_url: avatar_url,
    email: "#{login}#{n}@bar.baz",
    password: 'foobar'
  )
end

100.times do |n|
  name = Faker::Name.name
  login = Faker::HarryPotter.character.gsub(" ", "_")
  avatar_url = Faker::Avatar.image
  User.create(
    name: name,
    login: "#{login}_#{n}",
    avatar_url: avatar_url,
    email: "#{login}#{n}@bar.baz",
    password: 'foobar'
  )
end

users = User.all
users.each do |user|
  rand(5).times { user.posts.create!(text: Faker::HeyArnold.quote) }
end
