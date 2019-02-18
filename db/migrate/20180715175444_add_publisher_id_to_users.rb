class AddPublisherIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :publisher, index: false, foreign_key: true
  end
end
