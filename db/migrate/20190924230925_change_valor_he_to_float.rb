class ChangeValorHeToFloat < ActiveRecord::Migration[5.0]
  def change
    change_column :trabalhos, :valor_he, :float
    change_column :grupos, :valor_he_exce, :float
  end
end
