class AddTasksIndexToSomeIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :name
    add_index :tasks, :priority
    add_index :tasks, :situation
    add_index :tasks, :deadline
  end
end
