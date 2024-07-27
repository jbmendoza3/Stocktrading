class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  USER_TYPES = %w[trader admin].freeze

  validates :user_type, inclusion: { in: USER_TYPES }

  before_validation :set_default_user_type, on: :create

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
end

