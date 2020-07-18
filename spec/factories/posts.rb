FactoryBot.define do
  factory :post do
    title "テスト"
    summary "要約"
    review "感想"
    note "メモ"
    association :user
  end
end
