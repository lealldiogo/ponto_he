class AddUniqueToMembros < ActiveRecord::Migration[5.0]
  def change
    add_index :membros, [ :user_id, :grupo_id ], unique: true
  end
end
