class AddNomeCompletoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nome_completo, :string
  end
end
