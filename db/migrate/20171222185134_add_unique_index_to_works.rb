class AddUniqueIndexToWorks < ActiveRecord::Migration[5.1]
  def change
    add_index :works, [:book_id, :person_alias_id, :work_type_id], unique: true
    remove_index :works, :book_id
  end
end
