class Task < ApplicationRecord
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
    unknown: 0,
    low: 1,
    middle: 2,
    high: 3
  }
  enum situation: {
    stand_by: 0,
    started: 1,
    finished: 2
  }
end
