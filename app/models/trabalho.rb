class Trabalho < ApplicationRecord
  belongs_to :user
  belongs_to :obra, optional: true

  validates :data, uniqueness: { scope: :user }
  # validates :obra, presence: true, on: :update
  # validates :obra, presence: true, on: :update
end
