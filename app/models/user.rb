class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :stocks
  has_many :transactions

  scope :admins, -> { where(is_admin: true) }
  scope :traders, -> { where(is_admin: false) }
end
