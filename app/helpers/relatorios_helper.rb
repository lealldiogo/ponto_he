module RelatoriosHelper
  def soma_he_funcionario(func, periodo)
    range_periodo = periodo[0]..periodo[1]
    trabalhos_periodo = func.trabalhos.where(data: range_periodo)
    soma = 0.0
    trabalhos_periodo.each do |trab|
      byebug
      soma += (func.salario_cents.to_f/22000) * trab.horas_extras * trab.valor_he
    end
    return soma
  end

  def valor_he_dia(funcionario,trabalho)
    return (funcionario.salario_cents.to_f/22000) * trabalho.horas_extras * trabalho.valor_he
  end
end
