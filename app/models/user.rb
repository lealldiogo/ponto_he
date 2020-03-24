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

  def active_for_authentication?
    # Uncomment the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml
    super && self.ativo?
  end

  def inactive_message
    self.ativo? ? super : :account_inactive
  end

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
