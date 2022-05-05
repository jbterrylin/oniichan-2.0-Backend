class CreatePapers < ActiveRecord::Migration[6.1]
  def change
    create_table :papers do |t|
      t.string :name
      t.bigint :user_id
      t.string :type
      t.bigint :user_shop_id
      t.string :price_unit
      t.bigint :customer_id
      t.string :discount_unit
      t.string :discount
      t.string :deposit
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
