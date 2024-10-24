class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.integer :total_points
      t.string :status
      t.decimal :value
      t.json :match_stats

      t.timestamps
    end
  end
end
