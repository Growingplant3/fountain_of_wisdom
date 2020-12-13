class Task < ApplicationRecord
  has_many :label_tasks, dependent: :destroy
  has_many :labels, through: :label_tasks, source: :label
  belongs_to :user
  validates :name,
    presence: true,
    uniqueness: true
  validates :priority, :situation,
    presence: true
  validate :do_not_accept_past_dates

  def do_not_accept_past_dates
    if deadline.nil? || deadline < DateTime.now
      errors.add(:deadline, I18n.t("errors.messages.need_future_date"))
    end
  end

  enum priority: {
    low: 0,
    middle: 1,
    high: 2
  }
  enum situation: {
    stand_by: 0,
    started: 1,
    finished: 2
  }

  scope :ambiguous_name, -> (ambiguous_name) { where('name LIKE ?', "%#{ambiguous_name}%") }
  scope :situation_value, -> (situation_value) { where(situation: situation_value) }
end
