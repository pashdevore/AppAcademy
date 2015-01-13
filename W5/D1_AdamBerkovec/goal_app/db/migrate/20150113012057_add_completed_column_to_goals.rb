class AddCompletedColumnToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :completed, :boolean, null: false
    change_column :goals, :completed, :boolean, default: false
  end
end
