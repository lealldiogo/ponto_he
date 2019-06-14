class AddVeiculosToTrabalhos < ActiveRecord::Migration[5.0]
  def change
    add_reference :trabalhos, :veiculo, foreign_key: true
  end
end
