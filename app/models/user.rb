class User < ApplicationRecord
  after_update :there_is_an_administrator
  after_destroy :there_is_an_administrator
  has_many :tasks, dependent: :destroy
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
    format: { with: /[a-z\d@!?]{8,16}/, message: I18n.t("errors.messages.need_password_format") },
    allow_nil: true

  enum admin: {
    not_admin: false,
    admin: true
  } 

  private
  def there_is_an_administrator
    unless User.pluck(:admin).include?("admin")
      raise ActiveRecord::Rollback
    end
    # if User.where(admin: true).length <= 1 && self.admin == "admin"
    #   throw :abort
    # end
  end
end
