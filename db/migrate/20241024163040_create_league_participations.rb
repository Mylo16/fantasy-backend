class CreateLeagueParticipations < ActiveRecord::Migration[7.2]
  def change
    create_table :league_participations do |t|
      t.references :manager, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
