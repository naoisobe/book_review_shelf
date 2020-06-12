User.create!(name: "Example User",
            email: "example0@example0.com",
            password:  "hogehoge",
            password_confirmation: "hogehoge",
            admin: true)


100.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = "password"
  User.create(name: name, 
              email: email, 
              password: password, 
              password_confirmation: password)
end