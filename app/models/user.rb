class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable,
  :validatable, :timeoutable#, :rememberable #, :registerable

  has_many :trabalhos

  validates :username, uniqueness: true
  validates :cargo, presence: true
  validates :equipe, presence: true

  def timeout_in
    return 1.year if admin?
    2.minutes
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
