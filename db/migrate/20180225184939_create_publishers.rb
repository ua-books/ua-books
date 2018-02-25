class CreatePublishers < ActiveRecord::Migration[5.1]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_column :books, :publisher_id, :integer
    add_index :books, :publisher_id
    add_foreign_key :books, :publishers

    reversible do |dir|
      dir.up do
        execute <<-sql
          insert into publishers
          (name, created_at, updated_at)
          values ('initial', now(), now())
          ;

          update books set publisher_id = (select id from publishers limit 1)
        sql

        change_column_null :books, :publisher_id, false
      end
    end
  end
end
