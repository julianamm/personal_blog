# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "123"

Post.destroy_all
Comment.destroy_all
User.destroy_all

super_user = User.create(
    name: "JuJu",
    email: "juju@email.com",
    password: PASSWORD,
    admin: true
)

10.times do
    name = Faker::Name.name

    User.create(
        name: Faker::Name.name,
        email: "#{name.downcase}@example.com",
        password: PASSWORD
    )
end

users = User.all
puts Cowsay.say "Created #{users.count} users", :tux


50.times do
    p = Post.create(
        tittle: Faker::Book.title,
        body: Faker::Lorem.paragraphs,
        user: users.sample
    )

    if p.valid?
        rand(0..100).times do
          Comment.create(
            body: Faker::Friends.quote,
            post: p,
            user: users.sample
          )
        end
    end
end

posts = Post.all
comments = Comment.all
puts Cowsay.say "Created #{posts.count} posts", :cow
puts Cowsay.say "Created #{comments.count} comments", :turtle
puts "Login with #{super_user.email} and password of '#{PASSWORD}'"