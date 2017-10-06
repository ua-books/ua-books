class CreatePersonsAliasesAndWorks < ActiveRecord::Migration[5.1]
  def change
    reversible do |m|
      m.up   { execute "create type gender as enum('female', 'male')" }
      m.down { execute "drop type gender" }
    end

    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.column :gender, :gender, null: false
      t.timestamps
    end

    create_table :person_aliases do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.references :person, null: false, foreign_key: true, index: true
      t.timestamps
    end

    create_table :work_types do |t|
      t.string :name_feminine, null: false
      t.string :name_masculine, null: false
      t.timestamps
    end

    create_table :works do |t|
      t.references :book, null: false, foreign_key: true, index: true
      t.references :person_alias, null: false, foreign_key: true, index: true
      t.references :work_type, null: false, foreign_key: true
    end
  end
end
