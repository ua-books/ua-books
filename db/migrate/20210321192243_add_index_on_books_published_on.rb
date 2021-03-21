class AddIndexOnBooksPublishedOn < ActiveRecord::Migration[5.1]
  def change
    add_index :books, :published_on
  end
end
