class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name, unique: true
      t.text :detail
      t.integer :priority, null: false, default: 0
      t.integer :situation, null: false, default: 0
      t.time :deadline, null: false

      t.timestamps
    end
  end
end
