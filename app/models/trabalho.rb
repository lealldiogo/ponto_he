class Trabalho < ApplicationRecord
  belongs_to :user
  belongs_to :obra, optional: true

  validates :data, presence: true
  validates :data, uniqueness: { scope: :user }

  validates :obra, presence: true, on: :update
  validates :entrada, presence: true, on: :update
  validates :saida, presence: true, on: :update

  before_update :atualizar_status
  before_update :calcular_jornada

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
  end
end
