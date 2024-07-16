class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user,              null: false, foreign_key: true
      t.string     :item_name,         null: false
      t.text       :description,       null: false
      t.integer    :category_id,       null: false
      t.integer    :item_status_id,    null: false
      t.integer    :shipping_cost_id,  null: false
      t.integer    :shipping_day_id,   null: false
      t.integer    :shipping_area_id,  null: false
      t.integer    :price,             null: false

      t.timestamps
    end
  end
end
