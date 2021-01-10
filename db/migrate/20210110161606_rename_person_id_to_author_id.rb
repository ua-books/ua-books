class RenamePersonIdToAuthorId < ActiveRecord::Migration[5.1]
  def change
    rename_column :author_aliases, :person_id, :author_id
  end
end
