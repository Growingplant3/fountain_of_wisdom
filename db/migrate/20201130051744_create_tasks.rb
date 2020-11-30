class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :detail
      t.integer :priority
      t.integer :situation
      t.time :deadline

      t.timestamps
    end
  end
end
