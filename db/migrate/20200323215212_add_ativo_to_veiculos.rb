class AddAtivoToVeiculos < ActiveRecord::Migration[5.0]
  def change
    add_column :veiculos, :ativo, :boolean, default: true
  end
end
