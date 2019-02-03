module InfoFuncionariosHelper
  def verificar_pendencia(funcionario)
    trabalhos = []
    7.times do |i|
      # Ache ou crie um trabalho do usuário para a data
      trabalhos << Trabalho.find_or_create_by(data: Date.today - i, user_id: funcionario.id)
    end
    pendente = false
    trabalhos.each do |trabalho|
      if trabalho.status == "Pendente"
        puts trabalho.status
        pendente = true
      end
    end
    return pendente
  end
end
