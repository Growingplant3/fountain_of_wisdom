class User < ApplicationRecord
  has_secure_password
  before_validation { email.downcase! }

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 20 }
  validates :email, 
    presence: true,
    uniqueness: true,
    length: { maximum: 50 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,
    presence: true,
    length: { in: 8..16 },
    format: { with: /[a-z\d@#$_!?]{8,16}/, message: I18n.t("errors.messages.need_password_format") }
end
