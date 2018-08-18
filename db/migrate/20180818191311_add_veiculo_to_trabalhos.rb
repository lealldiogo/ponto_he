class AddVeiculoToTrabalhos < ActiveRecord::Migration[5.0]
  def change
    add_column :trabalhos, :veiculo, :string
  end
end
