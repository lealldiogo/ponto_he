class AddAtivoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ativo, :boolean, default: true
  end
end
