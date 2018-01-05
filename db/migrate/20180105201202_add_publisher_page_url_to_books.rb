class AddPublisherPageUrlToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :publisher_page_url, :string
  end
end
