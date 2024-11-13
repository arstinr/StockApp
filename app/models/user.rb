class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :stocks
  has_many :transactions

  validates :name, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :password, presence: true

  scope :admins, -> { where(is_admin: true) }
  scope :traders, -> { where(is_admin: false) }
end
