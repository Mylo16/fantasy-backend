class AddTeamToPlayers < ActiveRecord::Migration[7.2]
  def change
    add_reference :players, :team, null: false, foreign_key: true
    add_reference :players, :position, null: false, foreign_key: true
    add_reference :fixtures, :gameweek, null: false, foreign_key: true
    add_reference :fixtures, :home_team, null: false, foreign_key: { to_table: :teams }
    add_reference :fixtures, :away_team, null: false, foreign_key: { to_table: :teams }
    add_reference :managers, :league, null: false, foreign_key: true
    add_reference :manager_histories, :gameweek, null: false, foreign_key: true
    add_reference :manager_histories, :manager, null: false, foreign_key: true
    add_reference :my_teams, :manager, null: false, foreign_key: true
    add_reference :leagues, :manager, null: false, foreign_key: { to_table: :managers }

  end
end
