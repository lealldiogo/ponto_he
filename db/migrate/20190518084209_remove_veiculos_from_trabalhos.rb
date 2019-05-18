class RemoveVeiculosFromTrabalhos < ActiveRecord::Migration[5.0]
  def change
    remove_column :trabalhos, :veiculo, :string
  end
end
