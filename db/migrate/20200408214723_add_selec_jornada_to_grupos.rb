class AddSelecJornadaToGrupos < ActiveRecord::Migration[5.0]
  def change
    add_column :grupos, :selec_jornada, :boolean
  end
end
