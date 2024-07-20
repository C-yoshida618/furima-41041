class OrdersPurchases
  include ActiveModel::Model
  attr_accessor :token, :price, :item_id, :user_id, :postal_code, :shipping_area_id, :city, :block, :building, :phone_number

  validates :shipping_area_id, numericality: { other_than: 0, message: "can't be blank" }, presence: true
  validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :item_id, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }, presence: true
  validates :user_id, presence: true
  validates :city, presence: true
  validates :block, presence: true
  validates :token, presence: true

  # 建物名は任意
  validates :building, absence: false

  def save
    order = Order.create(user_id:, item_id:)
    Purchases.create(postal_code:, shipping_area_id:, city:, block:, building:,
                     phone_number:, order_id: order.id)
  end
end
