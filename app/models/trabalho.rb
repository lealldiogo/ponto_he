class Trabalho < ApplicationRecord
  belongs_to :user
  belongs_to :obra

  validates :data, uniqueness: { scope: :user }
end
