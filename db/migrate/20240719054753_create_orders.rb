class CreateOrders < ActiveRecord::Migration[7.0]
  def change
      add_references :orders,:user,         null: false, foreign_key: true
      add_references :orders,:item,         null: false, foreign_key: true
  end
end
