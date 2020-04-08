class AddJornadaBaseToTrabalhos < ActiveRecord::Migration[5.0]
  def change
    add_column :trabalhos, :jornada_base, :integer
  end
end
