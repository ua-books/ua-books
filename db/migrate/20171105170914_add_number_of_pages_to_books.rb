class AddNumberOfPagesToBooks < ActiveRecord::Migration[5.1]
  def up
    add_column :books, :number_of_pages, :integer
    execute "update books set number_of_pages = 0"
    change_column_null :books, :number_of_pages, false
  end

  def down
    remove_column :books, :number_of_pages
  end
end
