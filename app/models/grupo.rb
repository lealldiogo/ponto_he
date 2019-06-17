class Grupo < ApplicationRecord
  has_many :membros, dependent: :destroy
  has_many :users, through: :membros

  validate :inicio_ante_fim
  validate :overlap_periodos

  after_create :criar_trabalhos

  protected

  def inicio_ante_fim
    if self.inicio_exce > self.fim_exce
      errors.add(:fim_exce, "tem que ser depois do início do período de exceção, podendo ser iguais caso o período seja de apenas um dia")
    end
  end

  def overlap_periodos
    self.users.each do |func|
      if func.grupos.any?
        func.grupos.each do |grupo|
          if (grupo.inicio_exce < self.fim_exce) && (self.inicio_exce < grupo.fim_exce) && (grupo.id != self.id)
            errors.add(:users, "não podem fazer parte de mais de um grupo para uma mesma data. O funcionário " + func.nome_completo + " já faz parte do grupo " + grupo.nome)
          end
        end
      end
    end
  end

  def criar_trabalhos
    self.users.each do |func|
      trabalhos = []
      ((self.fim_exce-self.inicio_exce).to_i + 1).times do |i|
        # Ache ou crie um trabalho do usuário para a data
        trabalhos << Trabalho.find_or_create_by(data: self.fim_exce - i, user_id: func.id)
      end
      trabalhos.each do |trab|
        trab.valor_he = self.valor_he_exce
        trab.save!
      end
    end
  end
end
