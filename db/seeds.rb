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

grupo1 = Grupo.new(nome: "Seed", valor_he_exce: 2, inicio_exce: Date.new(2019,04,15), fim_exce: Date.new(2019,05,15))
grupo1.users << [pedro, ronaldo]
grupo1.save!
