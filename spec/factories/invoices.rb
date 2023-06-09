FactoryBot.define do
  factory :invoice do
    customer_id { rand 1..100 }
    status { rand(0..2) }
  end
end
