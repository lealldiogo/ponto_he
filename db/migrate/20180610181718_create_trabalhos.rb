class CreateTrabalhos < ActiveRecord::Migration[5.0]
  def change
    create_table :trabalhos do |t|
      t.references :user, foreign_key: true
      t.references :obra, foreign_key: true
      t.integer :valor_he
      t.date :data
      t.time :entrada
      t.time :saida
      t.string :status

      t.timestamps
    end
  end
end
