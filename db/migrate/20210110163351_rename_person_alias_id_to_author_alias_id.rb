class RenamePersonAliasIdToAuthorAliasId < ActiveRecord::Migration[5.1]
  def change
    rename_column :works, :person_alias_id, :author_alias_id
  end
end
