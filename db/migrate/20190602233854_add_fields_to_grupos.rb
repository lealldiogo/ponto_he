class AddFieldsToGrupos < ActiveRecord::Migration[5.0]
  def change
    add_column :grupos, :valor_he_exce, :integer
    add_column :grupos, :inicio_exce, :date
    add_column :grupos, :fim_exce, :date
  end
end
