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

Trabalho.destroy_all
Obra.destroy_all
Veiculo.destroy_all
User.destroy_all

gestor = User.new(admin: true, username: "julio.ribeiro", password: "123456")
gestor.save!

dev = User.new(admin: true, username: "diogo.leal", password: "123456")
dev.save!

joao = User.new(username: "joao.pedreiro", password: "123456", cargo: "Pedreiro", equipe: "Paraíba", nome_completo: "João Silva", apelido: "careca")
joao.save!

pedro = User.new(username: "pedro.pedreiro", password: "123456", cargo: "Pedreiro", equipe: "Recife", nome_completo: "Pedro dos Santos", apelido: "rato")
pedro.save!

jose = User.new(username: "jose.servente", password: "123456", cargo: "Servente", equipe: "Paraíba", nome_completo: "José Ferreira", apelido: "pança")
jose.save!

ronaldo = User.new(username: "ronaldo.servente", password: "123456", cargo: "Servente", equipe: "Recife", nome_completo: "Ronaldo Lima", apelido: "bigode")
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
