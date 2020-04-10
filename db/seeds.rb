# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin

DELETAR destroy_all UMA VEZ QUE O APLICATIVO ESTIVER ATIVO

=end

Membro.destroy_all
Grupo.destroy_all
Trabalho.destroy_all
Obra.destroy_all
Veiculo.destroy_all
User.destroy_all

gestor = User.new(admin: true, username: "julio.ribeiro", password: "123456", nome_completo: "Julio Ribeiro")
gestor.save!

dev = User.new(admin: true, username: "diogo.leal", password: "123456", nome_completo: "Diogo Leal")
dev.save!

joao = User.new(username: "joao.pedreiro", password: "123456", cargo: "Pedreiro", equipe: "Paraíba", nome_completo: "João Silva", apelido: "careca", salario: 1500)
joao.save!

pedro = User.new(username: "pedro.pedreiro", password: "123456", cargo: "Pedreiro", equipe: "Recife", nome_completo: "Pedro dos Santos", apelido: "rato", salario: 1500)
pedro.save!

jose = User.new(username: "jose.servente", password: "123456", cargo: "Servente", equipe: "Paraíba", nome_completo: "José Ferreira", apelido: "pança", salario: 2500)
jose.save!

ronaldo = User.new(username: "ronaldo.servente", password: "123456", cargo: "Servente", equipe: "Recife", nome_completo: "Ronaldo Lima", apelido: "bigode", salario: 2500)
ronaldo.save!

obra1 = Obra.new(nome: "Galpão")
obra1.save!

obra2 = Obra.new(nome: "Fábrica")
obra2.save!

obra3 = Obra.new(nome: "Depósito")
obra3.save!

veiculo1 = Veiculo.new(nome: "Kombi")
veiculo1.save!

veiculo2 = Veiculo.new(nome: "Caminhão")
veiculo2.save!

veiculo3 = Veiculo.new(nome: "Ônibus")
veiculo3.save!

grupo1 = Grupo.new(nome: "Seed", selec_valor: true, selec_duplo_trab: false, selec_jornada: true, jornada_exce: 9, valor_he_exce: 2, inicio_exce: Date.new(2020,2,15), fim_exce: Date.new(2020,3,15))
grupo1.users << [pedro, ronaldo]
grupo1.save!

# trabalho_pedro1 = Trabalho.new(data: Date.today - 6, entrada: Time.parse("18:00:00"), saida: Time.parse("22:00:00"), status: "Validado")
# trabalho_pedro2 = Trabalho.new(data: Date.today - 5, entrada: Time.parse("15:00:00"), saida: Time.parse("22:00:00"), status: "Validado")
# trabalho_pedro3 = Trabalho.new(data: Date.today - 4, entrada: Time.parse("18:00:00"), saida: Time.parse("20:00:00"), status: "Validado")
# trabalho_pedro4 = Trabalho.new(data: Date.today - 3, sem_he: true)

# trabalho_pedro1.user = pedro
# trabalho_pedro2.user = pedro
# trabalho_pedro3.user = pedro
# trabalho_pedro4.user = pedro

# trabalho_pedro1.obra = obra1
# trabalho_pedro2.obra = obra2
# trabalho_pedro3.obra = obra3

# trabalho_pedro1.veiculo = veiculo1
# trabalho_pedro2.veiculo = veiculo2
# trabalho_pedro3.veiculo = veiculo3

# trabalho_pedro1.save!
# trabalho_pedro2.save!
# trabalho_pedro3.save!
# trabalho_pedro4.save!

# trabalho_ronaldo1 = Trabalho.new(data: Date.today - 6, entrada: Time.parse("18:00:00"), saida: Time.parse("22:00:00"), status: "Validado")
# trabalho_ronaldo2 = Trabalho.new(data: Date.today - 5, entrada: Time.parse("15:00:00"), saida: Time.parse("22:00:00"), status: "Validado")
# trabalho_ronaldo3 = Trabalho.new(data: Date.today - 4, entrada: Time.parse("18:00:00"), saida: Time.parse("20:00:00"), status: "Validado")
# trabalho_ronaldo4 = Trabalho.new(data: Date.today - 3, sem_he: true)

# trabalho_ronaldo1.user = ronaldo
# trabalho_ronaldo2.user = ronaldo
# trabalho_ronaldo3.user = ronaldo
# trabalho_ronaldo4.user = ronaldo

# trabalho_ronaldo1.obra = obra1
# trabalho_ronaldo2.obra = obra2
# trabalho_ronaldo3.obra = obra3

# trabalho_ronaldo1.veiculo = veiculo1
# trabalho_ronaldo2.veiculo = veiculo2
# trabalho_ronaldo3.veiculo = veiculo3

# trabalho_ronaldo1.save!
# trabalho_ronaldo2.save!
# trabalho_ronaldo3.save!
# trabalho_ronaldo4.save!

