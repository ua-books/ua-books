class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.boolean :email_verified, null: false, default: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true

    create_table :oauth_providers do |t|
      t.string :name, null: false
      t.string :uid, null: false
      t.references :user, null: false, index: false, foreign_key: true
      t.datetime :created_at
    end
    add_index :oauth_providers, [:name, :uid], unique: true
  end
end
