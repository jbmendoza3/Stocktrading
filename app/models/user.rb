class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  USER_TYPES = %w[trader admin].freeze
  CREATION_STATUSES = %w[pending approved].freeze

  validates :user_type, inclusion: { in: USER_TYPES }
  validates :creation_status, inclusion: { in: CREATION_STATUSES }

  before_validation :set_default_user_type, on: :create
  before_validation :set_default_creation_status, on: :create

  after_create :send_appropriate_email

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :transactions, dependent: :destroy

  def trader?
    user_type == 'trader'
  end

  def admin?
    user_type == 'admin'
  end

  private

  def set_default_user_type
    self.user_type ||= 'trader'
  end

  def set_default_creation_status
    self.creation_status ||= 'pending'
  end

  def send_appropriate_email
    if self.creation_status == 'pending'
      send_pending_signup_email
    elsif self.creation_status == 'approved'
      send_approval_email
    end
  end

  def send_pending_signup_email
    UserMailer.with(user: self).pending_signup_email.deliver_now
  end

  def send_approval_email
    UserMailer.with(user: self).approval_email.deliver_now
  end
end
