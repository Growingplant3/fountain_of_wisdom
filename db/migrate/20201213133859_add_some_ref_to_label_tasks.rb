class AddSomeRefToLabelTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :label_tasks, :task, foreign_key: true
    add_reference :label_tasks, :label, foreign_key: true
  end
end
