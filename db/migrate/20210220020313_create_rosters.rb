class CreateRosters < ActiveRecord::Migration[6.0]
  def change
    create_table :rosters do |t|
      t.date :date, nul:false
      t.references :duty, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
