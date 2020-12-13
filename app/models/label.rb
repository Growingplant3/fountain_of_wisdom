class Label < ApplicationRecord
  validates :name, presence: true
  has_many :label_tasks, dependent: :destroy
  has_many :tasks, though: :label_tasks, source: :task
  belongs_to :user
end
