class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :item, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :production_status, null: false

      t.timestamps
    end
  end
end
