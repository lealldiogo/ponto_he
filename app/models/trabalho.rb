class Trabalho < ApplicationRecord
  belongs_to :user
  belongs_to :obra, optional: true

  before_update :atualizar_status

  validates :data, presence: true
  validates :data, uniqueness: { scope: :user }

  validates :obra, presence: true, on: :update
  validates :veiculo, presence: true, on: :update

  validates :entrada, presence: true, on: :update
  validates :saida, presence: true, on: :update
  validate :calcular_jornada, on: :update

  protected

  def atualizar_status
    if self.status == "Pendente"
      self.status = "Enviado"
    end
  end

  def calcular_jornada
    if self.entrada > self.saida
      if self.entrada.min > self.saida.min
        horas = 24 - self.entrada.hour + self.saida.hour - 1
        minutos = 60 - self.entrada.min + self.saida.min
      else
        horas = 24 - self.entrada.hour + self.saida.hour
        minutos = self.saida.min - self.entrada.min
      end
    else
      if self.entrada.min > self.saida.min
        horas = self.saida.hour - self.entrada.hour - 1
        minutos = 60 - self.entrada.min + self.saida.min
      else
        horas = self.saida.hour - self.entrada.hour
        minutos = self.saida.min - self.entrada.min
      end
    end
    jornada = horas + (minutos.to_f/60).round(2)
    if jornada == 0
      errors.add(:saida, "não pode ser igual a Entrada")
    end
  end

  def valor_he_padrao
    #TODO: definir valor de hora extra padrão com base no dia da semana
  end

  def sem_hora_extra
    #TODO: pular validações caso não haja hora extra no dia
  end
end
