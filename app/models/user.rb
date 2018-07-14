class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
