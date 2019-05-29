class Membro < ApplicationRecord
  belongs_to :user
  belongs_to :grupo
end
