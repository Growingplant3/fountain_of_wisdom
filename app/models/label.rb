class Label < ApplicationRecord
  validates :name, presence: true
  has_many :label_tasks, dependent: :destroy
  has_many :tasks, through: :label_tasks, source: :task
  belongs_to :user

  scope :label_value, -> (label_value) { where(name: label_value) }
end
