class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :payment

  attr_accessor :token

  validates :price, presence: true
end
