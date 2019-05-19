class Status < ApplicationRecord
  has_many :tracks
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :color, presence: true
end
