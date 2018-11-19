class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :equipe, :string
    add_column :users, :apelido, :string
  end
end
