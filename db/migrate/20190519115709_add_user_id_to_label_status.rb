class AddUserIdToLabelStatus < ActiveRecord::Migration[5.1]
  def change
    add_reference :labels, :user, index: true
    add_reference :statuses, :user, index: true

  end
end
