class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.boolean :is_deleted
      t.bigint :user_id
      t.bigint :paper_id

      t.timestamps
    end
  end
end
