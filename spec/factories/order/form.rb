FactoryBot.define do
  factory :order_form do
    item_id { 1 }
    user_id { 1 }
    postal_code { Faker::Number.between(from: 100, to: 999).to_s + '-' + Faker::Number.between(from: 1000, to: 9999).to_s }
    shipping_area_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    block { Faker::Address.block }
    building { Faker::Address.building }
    phone_number { '0' + Faker::Number.between(from: 100_000_000, to: 9_999_999_999).to_s }
  end
end
