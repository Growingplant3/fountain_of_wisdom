class CreateLabelTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :label_tasks do |t|

      t.timestamps
    end
  end
end
