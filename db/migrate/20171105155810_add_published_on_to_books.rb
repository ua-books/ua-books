class AddPublishedOnToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :published_on, :date, null: false, default: ->{ "current_date" }
  end
end
