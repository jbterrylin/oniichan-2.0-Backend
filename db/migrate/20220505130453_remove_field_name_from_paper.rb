class RemoveFieldNameFromPaper < ActiveRecord::Migration[6.1]
  def change
    remove_column :papers, :discount_unit, :string
  end
end
