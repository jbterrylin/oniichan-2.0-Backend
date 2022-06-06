class AddSsmToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :ssm, :string
  end
end
