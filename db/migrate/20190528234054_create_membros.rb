class CreateMembros < ActiveRecord::Migration[5.0]
  def change
    create_table :membros do |t|
      t.belongs_to :grupo, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
