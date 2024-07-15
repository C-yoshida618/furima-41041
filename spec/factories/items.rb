FactoryBot.define do
  factory :item do
    item_name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category_id { 1 }
    item_status_id { 1 }
    shipping_cost_id { 1 }
    shipping_day_id { 1 }
    shipping_area_id { 1 }
    price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
