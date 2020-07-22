FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "test#{n}"}
    summary "要約"
    review "感想"
    note "メモ"
    association :user
  end
end
