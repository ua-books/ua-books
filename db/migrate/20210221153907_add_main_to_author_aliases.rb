class AddMainToAuthorAliases < ActiveRecord::Migration[5.1]
  def change
    add_column :author_aliases, :main, :boolean, default: false
    add_index :author_aliases, [:author_id, :main], unique: true, where: "main"

    reversible do |dir|
      dir.up do
        execute <<~SQL
          update author_aliases
          set main = true, updated_at = now()
          where id in (
            select min(id)
            from author_aliases
            group by author_id
          )
        SQL
      end
    end
  end
end
