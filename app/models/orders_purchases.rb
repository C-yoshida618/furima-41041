class OrdersPurchases
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :shipping_area_id, :city, :block, :building, :phone_number

  validates :shipping_area_id, numericality: { other_than: 0 }
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :city
    validates :building
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    order = Order.create(price: price, user_id: user_id)
    Purchases.create(postal_code: postal_code, shipping_area_id: shipping_area_id, city: city, building: building,
                   phone_number: phone_number, order_id: order.id)
  end
end