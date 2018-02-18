class AddStateToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :state, :string, null: false, default: "draft"
    add_index :books, :state

    reversible do |dir|
      dir.up do
        execute "update books set state = 'published'"
      end
    end
  end
end
