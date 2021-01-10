class RenamePersonAliasesToAuthorAliases < ActiveRecord::Migration[5.1]
  def change
    rename_table "person_aliases", "author_aliases"
  end
end
