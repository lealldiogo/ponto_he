class Membro < ApplicationRecord
  belongs_to :user
  belongs_to :grupo, inverse_of: :membros

  validates :user, uniqueness: {scope: :grupo}
end
