class AddLikeToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :like, :boolean
  end
end
