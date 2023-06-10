FactoryBot.define do
  factory :coupon do
    name { Faker::Science.element }
    code { Faker::Alphanumeric.alphanumeric(number: 5) }
    status { rand(0..1) }
    discount_type { rand(0..1) }
    discount_amount { rand(0..50) }
    merchant_id { rand(1..20) }
  end
end