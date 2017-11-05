class AddTitleToWork < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :title, :boolean, null: false, default: false
  end
end
