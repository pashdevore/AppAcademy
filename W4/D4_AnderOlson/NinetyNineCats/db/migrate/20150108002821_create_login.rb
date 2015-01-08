class CreateLogin < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.integer :user_id, null: false
      t.string :token, null: false, uniqueness: true
      t.index :user_id
      t.index :token

      t.timestamps
    end
  end
end
