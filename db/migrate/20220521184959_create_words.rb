class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :cn
      t.string :en
      t.string :category

      t.timestamps
    end
  end
end
