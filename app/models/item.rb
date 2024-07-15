class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  # テーブルとのアソシエーション
  belongs_to :user
  has_one    :purchase
  # has_many :comments

  # active_storageとのアソシエーション
  # （items・active_storage_blobsテーブルを関連付け）
  has_one_attached :image

  # アクティブハッシュとのアソシエーション
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :shipping_area
  belongs_to :shipping_day

  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :user
    validates :category_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :shipping_area_id
    validates :shipping_day_id
    # 300円以上かつ9,999,999円以下で、半角数字でないと入力不可
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end

  # ジャンルの選択が「--」の時は保存不可
  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :shipping_area_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :shipping_day_id
  end
end
