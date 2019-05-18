class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.datetime :due_date
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :tasks, :deleted_at
  end
end
