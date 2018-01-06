class AddDescriptionMdToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :description_md, :text
  end
end
