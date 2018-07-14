class ChangeUserEmail < ActiveRecord::Migration[5.0]
  def up
    change_column :users, :email, :string, null: true, unique: false, default: nil
  end

  def down
    change_column :users, :email, :string, null: false, unique: true, default: ""
  end
end
