FactoryBot.define do
  factory :orders_purchases do
    postal_code { '123-4567' }
    shipping_area_id { 1 }
    city { '東京都' }
    block { '1-1' }
    building { '東京ハイツ' }

    phone_number { Faker::Number.decimal_part(digits: 11) }
    token { 'R4i9AWyMoSwdtMOgqahB6rL' }
  end
end
