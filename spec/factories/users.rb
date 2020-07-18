FactoryBot.define do
  
  factory :user do
    name "sample"
    sequence(:email) { |n| "tester#{n}@example.com"}
    password "password"
  end


end
