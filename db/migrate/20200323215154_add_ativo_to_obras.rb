class AddAtivoToObras < ActiveRecord::Migration[5.0]
  def change
    add_column :obras, :ativo, :boolean, default: true
  end
end
