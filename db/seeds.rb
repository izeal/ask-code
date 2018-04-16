User.create(
    name:'Ivan',
    login:'izeal',
    email: 'foo@bar.baz',
    password: 'foobar',
    avatar_url: 'https://avatars3.githubusercontent.com/u/31633474?s=460&v=4'
)

6.times do |n|
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
