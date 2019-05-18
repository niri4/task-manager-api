class Task < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true
  validates :due_date, presence: true
end
