class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :availability
      t.integer :total_points
      t.string :status
      t.decimal :value
      t.json :match_stats
      t.integer :goals
      t.integer :assists
      t.integer :clean_sheets
      t.integer :goals_conceded
      t.integer :own_goals
      t.integer :penalties_saved
      t.integer :penalties_missed
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :saves
      t.integer :bonus
      t.integer :bonus_points
      t.integer :starts
      t.timestamps
    end
  end
end
