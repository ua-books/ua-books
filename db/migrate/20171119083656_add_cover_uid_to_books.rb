class AddCoverUidToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :cover_uid, :string
  end
end
