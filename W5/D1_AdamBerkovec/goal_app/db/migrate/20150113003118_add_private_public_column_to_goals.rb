class AddPrivatePublicColumnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private_goal, :boolean, null: false
    change_column :goals, :private_goal, :boolean, default: false
  end
end
