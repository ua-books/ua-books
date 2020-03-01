class RemoveCoverUrlFromBooks < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :cover_url, :string
  end
end
