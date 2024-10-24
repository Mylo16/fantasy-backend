class CreateFantasyTeamPlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :fantasy_team_players do |t|
      t.references :my_team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
