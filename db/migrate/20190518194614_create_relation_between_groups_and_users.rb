class CreateRelationBetweenGroupsAndUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :grupos, :user, foreign_key: true
    add_reference :users, :grupo, foreign_key: true
  end
end
