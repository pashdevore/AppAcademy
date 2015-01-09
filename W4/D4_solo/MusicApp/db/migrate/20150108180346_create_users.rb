class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, uniqueness: true
      t.string :password_digest, null: false
      t.string :token, null: false, uniqueness: true

      #same as add_index(:users, :session_token)
      t.index  :token

      t.timestamps null: false
    end
  end
end
