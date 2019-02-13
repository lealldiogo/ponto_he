class Trabalho < ApplicationRecord
  belongs_to :user
  belongs_to :obra, optional: true

  before_update :valor_he_padrao
  before_update :calcular_jornada

  validates :data, presence: true
  validates :data, uniqueness: { scope: :user }

  validates :obra, presence: true, on: :update, unless: :sem_hora_extra?
  validates :veiculo, presence: true, on: :update, unless: :sem_hora_extra?

  validates :entrada, presence: true, on: :update, unless: :sem_hora_extra?
  validates :saida, presence: true, on: :update, unless: :sem_hora_extra?

  after_update :atualizar_status

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
    #DONE: definir valor de hora extra padrão com base no dia da semana
    #TODO: criar array com datas dos feriados no recife e na paraíba(ignorar municipais nesse caso?)
    #TODO: adicionar um include?(self.data) como condição para valor_he = 100%
    # feriados = Feriado.all
    if self.data.strftime("%A") == "Sunday"
      self.valor_he = 100
    else
      # if feriados.include?(self.data)
        # self.valor_he = 100
      # else
      self.valor_he = 70
      # end
    end
  end

  def sem_hora_extra?
    #TODO: pular validações caso não haja hora extra no dia
    self.sem_he
  end
end
