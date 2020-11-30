class Task < ApplicationRecord
  validates :name,
    presence: true,
    uniqueness: true
  validates :priority, :situation, :deadline,
    presence: true

  enum priority: {
    unknown: 0,
    low: 1,
    middle: 2,
    hight: 3
  }
  enum situation: {
    stand_by: 0,
    started: 1,
    finished: 2
  }
end
