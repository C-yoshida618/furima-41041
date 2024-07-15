FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category_id { 1 }
    item_status_id { 1 }
    shipping_cost_id { 1 }
    shipping_day_id { 1 }
    shipping_area_id { 1 }
    price { 1000 }
    association :user
  end
end
