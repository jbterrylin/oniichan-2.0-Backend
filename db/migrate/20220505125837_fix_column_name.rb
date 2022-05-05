class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :papers, :type, :paper_type
  end
end
