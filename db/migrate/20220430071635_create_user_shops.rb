class CreateUserShops < ActiveRecord::Migration[6.1]
  def change
    create_table :user_shops do |t|
      t.string :name
      t.string :address
      t.string :ssm
      t.string :boss_name
      t.string :boss_phone
      t.bigint :user_id
      t.string :nick_name
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
