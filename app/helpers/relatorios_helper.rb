module RelatoriosHelper
  def soma_he_funcionario(func, periodo)
    range_periodo = periodo[0]..periodo[1]
    trabalhos_periodo = func.trabalhos.where(data: range_periodo).where(trabalhos: {sem_he: false}).where.not(trabalhos: {status: "Pendente"})
    soma = 0
    trabalhos_periodo.each do |trab|
      horas_extras = calcular_jornada(trab)
      soma += (func.salario_cents.to_f/220) * horas_extras * trab.valor_he
    end
    return Money.new(soma)
  end

  def valor_he_dia(funcionario,trabalho)
    horas_extras = calcular_jornada(trabalho)
    return Money.new((funcionario.salario_cents.to_f/220) * horas_extras * trabalho.valor_he)
  end

  def calcular_jornada(trabalho)
    if trabalho.entrada > trabalho.saida
      if trabalho.entrada.min > trabalho.saida.min
        horas = 24 - trabalho.entrada.hour + trabalho.saida.hour - 1
        minutos = 60 - trabalho.entrada.min + trabalho.saida.min
      else
        horas = 24 - trabalho.entrada.hour + trabalho.saida.hour
        minutos = trabalho.saida.min - trabalho.entrada.min
      end
    else
      if trabalho.entrada.min > trabalho.saida.min
        horas = trabalho.saida.hour - trabalho.entrada.hour - 1
        minutos = 60 - trabalho.entrada.min + trabalho.saida.min
      else
        horas = trabalho.saida.hour - trabalho.entrada.hour
        minutos = trabalho.saida.min - trabalho.entrada.min
      end
    end
    jornada = horas + (minutos.to_f/60).round(2)
    return jornada
    # if jornada == 0
    #   errors.add(:saida, "não pode ser igual a Entrada")
    # else
    #   self.horas_extras = jornada
    # end
  end
end
