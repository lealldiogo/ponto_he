module RelatoriosHelper
  def soma_he_funcionario(func, periodo)
    range_periodo = periodo[0]..periodo[1]
    trabalhos_periodo = func.trabalhos.where(data: range_periodo)
    soma = 0.0
    trabalhos_periodo.each do |trab|
      soma += (func.salario/220) * trab.horas_extras * ((trab.valor_he+100)/100)
    end
    return soma
  end

  def valor_he_dia(funcionario,trabalho)
    (funcionario.salario/220) * trabalho.horas_extras * ((trabalho.valor_he+100)/100)
  end
end
