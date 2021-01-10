class RenamePeopleToAuthors < ActiveRecord::Migration[5.1]
  def change
    rename_table "people", "authors"
  end
end
