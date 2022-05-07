class AddFk < ActiveRecord::Migration[6.1]
  def change
    add_reference :customers, :users
    remove_column :customers, :user_id, :bigint

    add_reference :items, :papers
    add_reference :items, :users
    remove_column :items, :paper_id, :bigint
    remove_column :items, :user_id, :bigint

    add_reference :papers, :users
    add_reference :papers, :user_shops
    add_reference :papers, :customers
    remove_column :papers, :user_id, :bigint
    remove_column :papers, :user_shop_id, :bigint
    remove_column :papers, :customer_id, :bigint

    add_reference :user_shops, :users
    remove_column :user_shops, :user_id, :bigint

    remove_column :user_shops, :is_deleted, :bigint
  end
end
