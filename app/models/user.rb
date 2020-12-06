class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }

  validates :name,
    presence: true,
    uniqueness: true
    length: { maximum: 20 }
  validates :email, 
    presence: true,
    uniqueness: true,
    length: { maximum: 50 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password
    presence: true,
    length: { in: 8..16 },
    format: { with: /\A[a-z\d@#$_!?]{8,16}\z/ }
  validate :do_not_accept_without_password_format

  def do_not_accept_without_password_format
    errors.add(:password, I18n.t(errors.messages.need_password_format))
  end
end
