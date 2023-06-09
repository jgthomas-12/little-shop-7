FactoryBot.define do
  factory :transaction do
    invoice_id { rand(1..100) }
    credit_card_number { Faker::Number.number(digits: 16).to_s }
    result { rand(0..1) }
    credit_card_expiration_date { Faker::Number.number(digits: 4) }
  end
end
