class RemoveBooksCoverUid < ActiveRecord::Migration[5.1]
  def up
    remove_column :books, :cover_uid
  end

  def down
  end
end
