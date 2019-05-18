class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :name
      t.string :color
      t.timestamps
    end
  end
end
