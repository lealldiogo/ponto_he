class AddOptionsToGrupos < ActiveRecord::Migration[5.0]
  def change
    add_column :grupos, :selec_valor, :boolean
    add_column :grupos, :selec_duplo_trab, :boolean
  end
end
