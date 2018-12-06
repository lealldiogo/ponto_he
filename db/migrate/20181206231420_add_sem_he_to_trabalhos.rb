class AddSemHeToTrabalhos < ActiveRecord::Migration[5.0]
  def change
    add_column :trabalhos, :sem_he, :boolean
  end
end
