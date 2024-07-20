class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.references :order,         null: false, foreign_key: true
      t.string :postal_code,       null: false
      t.integer :shipping_area_id, null: false
      t.string :city,              null: false
      t.string :block,             null: false
      t.string :building
      t.string :phone_number,      null: false
      t.timestamps
    end
  end
end
