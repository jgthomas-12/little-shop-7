FactoryBot.define do
  factory :merchant do
    name {Faker::Company.name}
    status { rand(0..1) }
  end
end
