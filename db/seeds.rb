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
User.destroy_all


joao = User.new(username: "joao.pedreiro", password: "123456", cargo: "Pedreiro")
joao.save!

jose = User.new(username: "jose.servente", password: "123456", cargo: "Servente")
jose.save!

obra1 = Obra.new(nome: "Galpão")
obra1.save!

obra2 = Obra.new(nome: "Fábrica")
obra2.save!

obra3 = Obra.new(nome: "Depósito")
obra3.save!
