class ChangeDefaultValueSemHe < ActiveRecord::Migration[5.0]
  def up
    change_column :trabalhos, :sem_he, :boolean, default: false
  end

  def down
    change_column :trabalhos, :sem_he, :boolean, default: nil
  end
end
