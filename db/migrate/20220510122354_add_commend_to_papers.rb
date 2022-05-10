class AddCommendToPapers < ActiveRecord::Migration[6.1]
  def change
    add_column :papers, :comment, :string
    add_column :user_shops, :comment, :string
  end
end
