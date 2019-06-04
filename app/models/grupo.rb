class Grupo < ApplicationRecord
  has_many :membros
  has_many :users, through: :membros

  validate :inicio_ante_fim
  validate :overlap_periodos

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
          if (grupo.inicio_exce < self.fim_exce) && (self.inicio_exce < grupo.fim_exce)
            errors.add(:users, "não podem fazer parte de mais de um grupo para uma mesma data. O funcionário " + func.nome_completo + " já faz parte do grupo " + grupo.nome)
          end
        end
      end
    end
  end
end
