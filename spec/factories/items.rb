FactoryBot.define do
  factory :item do
    merchant_id { rand(1..100) }
    name { Faker::Commerce.product_name }
    description { Faker::Hipster.sentence(word_count: 3) }
    unit_price { Faker::Number.between(from: 1, to: 10000)}
    status { rand(0..1) }
  end
end
