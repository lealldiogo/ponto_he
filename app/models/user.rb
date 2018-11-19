class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable,
  :validatable, :timeoutable#, :rememberable #, :registerable

  has_many :trabalhos

  validates :username, uniqueness: true
  validates :cargo, presence: true

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
