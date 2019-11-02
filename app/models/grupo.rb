class Grupo < ApplicationRecord
  has_many :membros, dependent: :destroy
  has_many :users, through: :membros

  attr_accessor :inicio_antigo
  attr_accessor :fim_antigo

  validates :valor_he_exce, inclusion: { in: [1.5, 1.7, 2] }

  validate :inicio_ante_fim
  validate :overlap_periodos

  after_create :atualizar_trabalhos
  before_update :retornar_padrao
  after_update :atualizar_trabalhos
  before_destroy :retornar_padrao_delete

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

  #Atualizar o valor da hora extra dos trabalhos aós a criação do grupo
  def atualizar_trabalhos
    self.users.each do |func|
      trabalhos = []
      ((self.fim_exce-self.inicio_exce).to_i + 1).times do |i|
        # TODO: buscar todos os trabalhos para o período passado (use where combinado com um each antes de fazer o append)
        # OLD APPROACH: Ache ou crie um trabalho do usuário para a data
        trabalhos << Trabalho.find_or_create_by(data: self.fim_exce - i, user_id: func.id)
      end
      trabalhos.each do |trab|
        if trab.status != "Validado"
          trab.update_columns(valor_he: self.valor_he_exce)
        end
      end
    end
  end

  #Caso o período do grupo seja atualizado e o trabalho não tenha sido validado,
  #retornar o valor de hora extra para o padrão.
  def retornar_padrao
    self.users.each do |func|
      #trabalhos = []
      #((Date.parse(self.fim_antigo)-c).to_i + 1).times do |i|
        # TODO: buscar todos os trabalhos para o período passado (use where)
        # OLD APPROACH: Ache ou crie um trabalho do usuário para a data
        #trabalhos << Trabalho.find_or_create_by(data: Date.parse(self.fim_antigo) - i, user_id: func.id)
      #end
      trabalhos = Trabalho.where(data: Date.parse(self.inicio_antigo)..Date.parse(self.fim_antigo), user_id: func.id)
      trabalhos.each do |trab|
        if trab.status != "Validado"
          if trab.data.strftime("%A") == "Sunday"
            trab.update_columns(valor_he: 2)
          elsif trab.data.strftime("%A") == "Saturday"
            trab.update_columns(valor_he: 1.7)
          else
            trab.update_columns(valor_he: 1.5)
          end
        end
      end
    end
  end

  #Caso o grupo seja excluído e o trabalho não tenha sido validado,
  #retornar o valor de hora extra para o padrão.
  def retornar_padrao_delete
    self.users.each do |func|
      #trabalhos = []
      #((self.fim_exce-self.inicio_exce).to_i + 1).times do |i|
        # TODO: buscar todos os trabalhos para o período passado (use where)
        # OLD APPROACH: Ache ou crie um trabalho do usuário para a data
        #trabalhos << Trabalho.find_or_create_by(data: self.fim_exce - i, user_id: func.id)
      #end
      trabalhos = Trabalho.where(data: Date.parse(self.inicio_antigo)..Date.parse(self.fim_antigo), user_id: func.id)
      trabalhos.each do |trab|
        if trab.status != "Validado"
          if trab.data.strftime("%A") == "Sunday"
            trab.update_columns(valor_he: 2)
          elsif trab.data.strftime("%A") == "Saturday"
            trab.update_columns(valor_he: 1.7)
          else
            trab.update_columns(valor_he: 1.5)
          end
        end
      end
    end
  end
end
