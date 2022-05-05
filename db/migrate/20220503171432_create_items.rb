class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :description
      t.string :unit_price
      t.string :unit
      t.integer :sort_id
      t.bigint :paper_id
      t.boolean :is_deleted
      t.bigint :user_id

      t.timestamps
    end
  end
end
