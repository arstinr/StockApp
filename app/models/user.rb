class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :stocks
  has_many :transactions

  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :password, presence: true, if: :password_required?

  scope :admins, -> { where(is_admin: true) }
  scope :traders, -> { where(is_admin: false) }

  scope :pending, -> { where(is_approved: false, is_admin: false) }

  private
  def password_required?
    new_record? || password.present?
  end
end
