class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 50 }
  validates :phone_number, presence: true, numericality: true, length: { is: 11 }
  validates :address, presence: true, length: { maximum: 255 }
end
