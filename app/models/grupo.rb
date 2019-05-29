class Grupo < ApplicationRecord
  has_many :membros
  has_many :users, through: :membros
end
