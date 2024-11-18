class CreateFixtures < ActiveRecord::Migration[7.2]
  def change
    create_table :fixtures do |t|
      t.datetime :date
      t.boolean :completed
      t.datetime :kickoff_time
      t.boolean :started
      t.integer :away_team_score
      t.integer :home_team_score


      t.timestamps
    end

    create_table :stats do |t|
      t.string :identifier
      t.json :home_stats, default: []
      t.json :away_stats, default: []

      t.timestamps
    end

  end
end
