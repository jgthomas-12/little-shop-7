FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price { rand(1..10000) }
    status { rand(0..2) }
    invoice_id { rand(1..100) }
    item_id { rand(1..100) }
  end
end
