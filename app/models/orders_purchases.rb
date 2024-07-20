class OrdersPurchases
  include ActiveModel::Model
  attr_accessor :token, :item_id, :user_id, :postal_code, :shipping_area_id, :city, :block, :building, :phone_number

  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }

  with_options presence: true do
    validates :shipping_area_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :item_id
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :city
    validates :Block
    validates :token
  end
  # 建物名は任意
  validates :building, absence: false

  def save
    order = Order.create(user_id:, item_id:)
    Address.create(postal_code:, shipping_area_id:, city:, block:, building:,
                   phone_number:, order_id: order.id)
  end
end
