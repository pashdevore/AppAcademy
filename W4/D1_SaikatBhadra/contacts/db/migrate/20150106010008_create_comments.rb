class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :commentable_id, null:false
      t.string :commentable_type, null:false
      t.string  :text, null:false

      t.timestamps null: false
    end
  end
end
