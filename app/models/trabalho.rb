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

  validates :valor_he, inclusion: { in: [1.5, 1.7, 2.0], allow_blank: true}
  # validates :valor_he, inclusion: { in: [1.5, 1.7, 2], allow_blank: true}, on: :create

  validates :jornada_base, inclusion: { in: [0, 9, 10], allow_blank: true }

  # check how to handle valor_he correctly
  before_create :valor_he_padrao
  before_create :determinar_jornada_base
  before_create :calcular_jornada
  before_save :atualizar_status

  protected

  def atualizar_status
    # Obs: isso aqui não está funcionando pq estou empurrando o valor "Validado"
    # na partial _formulario_validacao.html.erb
    # Na verdade só precisava mudar o callback pra after_save
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
    # outro_dia = false
    if self.entrada > self.saida
      # outro_dia = true
      horas = 24 - self.entrada.hour - 1
      minutos = 60 - self.entrada.min
      # Tentativa de evitar erros caso a saída seja 00:00
      if self.saida.hour != 0 || self.saida.min != 0
        # byebug
        novo_dia_saida = self.saida
        novo_dia = Trabalho.create(data: (self.data + 1), entrada: Time.parse("00:00:00"), saida: novo_dia_saida, user_id: self.user.id, obra_id: self.obra.id, sem_he: false, veiculo_id: self.veiculo.id, status: "Pendente")
        self.saida = Time.parse("00:00:00")
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
    # byebug
    if jornada == 0
      errors.add(:saida, "não pode ser igual a Entrada")
    else
      (jornada - self.jornada_base) > 0 ? self.horas_extras = jornada - self.jornada_base : 0
      # if outro_dia
      #   #TODO: Criar função novo_dia() para criar um novo trabalho para o novo dia uma vez que vira a noite.
      #   novo_dia
      #   # if self.entrada.min > 0
      #   horas = 24 - self.entrada.hour - 1
      #   # na hora de fazer a divisão por 60 uma hora será adicionada no caso de o'clocks
      #   minutos = 60 - self.entrada.min
      #   # else
      #   #   horas = 24 - self.entrada.hour
      #   #   minutos = 0
      #   # end
      #   jornada = horas + (minutos.to_f/60).round(2)
      # byebug
      # else
      #   if (self.data.strftime("%A") == "Saturday") || (self.data.strftime("%A") == "Sunday")
      #     self.horas_extras = jornada
      #   elsif self.data.strftime("%A") == "Friday"
      #     (jornada - 9) > 0 ? self.horas_extras = jornada - 9 : 0
      #   else
      #     (jornada - 10) > 0 ? self.horas_extras = jornada - 10 : 0
      #   end
      # end
    end
  end

  def novo_dia
    # cálculo direto, pois começa a contar a partir das 00:00
    horas = self.saida.hour
    minutos = self.saida.min
    jornada = horas + (minutos.to_f/60).round(2)
    if (self.data.strftime("%A") == "Friday") || (self.data.strftime("%A") == "Saturday")
      nd_horas_extras = jornada
    elsif self.data.strftime("%A") == "Thursday"
      (jornada - 9) > 0 ? nd_horas_extras = jornada - 9 : 0
    else
      (jornada - 10) > 0 ? nd_horas_extras = jornada - 10 : 0
    end
    Trabalho.create()
  end

  def determinar_jornada_base
    if !data_inclusa_excecao?
      if (self.data.strftime("%A") == "Saturday") || (self.data.strftime("%A") == "Sunday")
        self.jornada_base = 0
      elsif self.data.strftime("%A") == "Friday"
        self.jornada_base = 9
      else
        self.jornada_base = 10
      end
    else
      self.jornada_base = Grupo.joins(:membros).where(membros: {user: User.last}).where("inicio_exce < ?", self.data).where("fim_exce > ?", self.data).first.jornada_exce
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
    else
      self.valor_he = Grupo.joins(:membros).where(membros: {user: User.last}).where("inicio_exce < ?", self.data).where("fim_exce > ?", self.data).first.valor_he_exce
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
