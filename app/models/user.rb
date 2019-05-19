class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  has_many :labels
  has_many :statuses
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
end
