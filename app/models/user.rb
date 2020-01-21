class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable,
  :validatable, :timeoutable#, :rememberable #, :registerable

  monetize :salario_cents

  has_many :trabalhos

  has_many :membros
  has_many :grupos, through: :membros

  validates :username, uniqueness: true
  validates :cargo, presence: true, unless: :admin?
  validates :nome_completo, presence: :true, unless: :admin?

  validates :equipe, presence: true, unless: :admin?
  validates :equipe, inclusion: { in: ["Recife", "Paraíba"] }, unless: :admin?

  def timeout_in
    return 1.year if admin?
    5.minutes
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
