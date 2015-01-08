class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false, uniqueness: true
      t.string :password_digest, null: false
      t.string :session_token, null: false, uniqueness: true

      t.timestamps
    end

    add_index(:users, :session_token)
  end
end
