class AddJornadaExceToGrupos < ActiveRecord::Migration[5.0]
  def change
    add_column :grupos, :jornada_exce, :integer
  end
end
