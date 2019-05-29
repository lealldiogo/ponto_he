class Grupo < ApplicationRecord
  has_many :membros
  has_many :users, through: :membros
  #accepts_nested_attributes_for :membros
end
