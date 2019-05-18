class AddMigrationToTask < ActiveRecord::Migration[5.1]
  def change
    add_reference :tasks, :label, index: true
    add_reference :tasks, :status, index: true
  end
end
