FactoryBot.define do
  factory :orders_purchases do
    postal_code { '123-4567' }
    shipping_area { 1 }
    city { '東京都' }
    block { '1-1' }
    building { '東京ハイツ' }
    price { 2000 }
  end
end
