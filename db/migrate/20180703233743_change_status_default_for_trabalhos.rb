class ChangeStatusDefaultForTrabalhos < ActiveRecord::Migration[5.0]
  def up
    change_column :trabalhos, :status, :string, default: "Pendente"
  end

  def down
    change_column :trabalhos, :status, :string, default: nil
  end
end
