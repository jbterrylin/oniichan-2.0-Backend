class AddFkToWords < ActiveRecord::Migration[6.1]
  def change
    add_reference :words, :users
  end
end
