class AddHorasExtrasToTrabalhos < ActiveRecord::Migration[5.0]
  def change
    add_column :trabalhos, :horas_extras, :float, default: 0
  end
end
