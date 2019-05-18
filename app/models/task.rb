class Task < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :due_date, presence: true
  belongs_to :label
  belongs_to :status
  belongs_to :user
end
