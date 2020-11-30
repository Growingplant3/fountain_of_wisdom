class Task < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true
  validates :priority, :situation, :deadline,
    presence: true
end
