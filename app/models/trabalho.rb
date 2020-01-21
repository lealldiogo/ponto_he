class Trabalho < ApplicationRecord
  belongs_to :user
  belongs_to :obra, optional: true
  belongs_to :veiculo, optional: true

  validates :data, presence: true
  validates :data, uniqueness: { scope: :user }, unless: :multiplas_he?
  validate :condicoes_data

  validates :obra, presence: true, unless: :sem_hora_extra?
  validates :veiculo, presence: true, unless: :sem_hora_extra?

  validates :entrada, presence: true, unless: :sem_hora_extra?
  validates :saida, presence: true, unless: :sem_hora_extra?

  validates :valor_he, inclusion: { in: [1.5, 1.7, 2], allow_blank: true}
  # validates :valor_he, inclusion: { in: [1.5, 1.7, 2], allow_blank: true}, on: :create

  # check how to handle valor_he correctly
  before_create :valor_he_padrao
  before_create :calcular_jornada
  before_create :atualizar_status

  protected

  def atualizar_status
    # byebug
    if self.status == "Pendente"
      self.status = "Enviado"
    elsif self.status == "Enviado"
      self.status = "Validado"
    end
  end

  # Esse cálculo foi movido para o helper dos relatórios.
  # Está sendo mantido aqui também até que essa modificação seja validada e
  # a coluna horas_extras retirada da tabela trabalhos
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
    else
      self.horas_extras = jornada
    end
  end

  def valor_he_padrao
    #DONE: definir valor de hora extra padrão com base no dia da semana
    #TODO: criar array com datas dos feriados no recife e na paraíba(ignorar municipais nesse caso?)
    #TODO: adicionar um include?(self.data) como condição para valor_he = 100%
    # feriados = Feriado.all
    if !data_inclusa_excecao?
      if self.data.strftime("%A") == "Sunday"
        self.valor_he = 2
      elsif self.data.strftime("%A") == "Saturday"
        self.valor_he = 1.7
      else
      # if feriados.include?(self.data)
        # self.valor_he = 100
      # else
        self.valor_he = 1.5
      # end
      end
    end
  end

  def condicoes_data
    if !data_inclusa_excecao?
      if (Date.today - self.data) > 7
        errors.add(:data, "não pode ser anterior a " + (Date.today - 7).strftime("%d/%m/%Y"))
      elsif (Date.today - self.data) < 0
        errors.add(:data, "não pode ser uma data futura")
      end
    end
  end

  def sem_hora_extra?
    #TODO: pular validações caso não haja hora extra no dia
    self.sem_he
  end

  def multiplas_he?
    #TODO: adicionar checkbox nos grupos e refatorar a abordagem geral,
    #caso decida realmente fazer isso.
    data_exce = false
    if self.user.grupos.any?
      self.user.grupos.each do |grupo|
        if (self.data >= grupo.inicio_exce) && (self.data <= grupo.fim_exce)
          data_exce = true
        end
      end
    end
    return data_exce
  end

  def data_inclusa_excecao?
    data_exce = false
    if self.user.grupos.any?
      self.user.grupos.each do |grupo|
        if (self.data >= grupo.inicio_exce) && (self.data <= grupo.fim_exce)
          data_exce = true
          break
        end
      end
    end
    return data_exce
  end
end
