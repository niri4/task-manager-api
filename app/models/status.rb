class Status < ApplicationRecord
  has_many :tracks
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :color, presence: true
end
