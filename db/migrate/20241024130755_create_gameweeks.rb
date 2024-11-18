class CreateGameweeks < ActiveRecord::Migration[7.2]
  def change
    create_table :gameweeks do |t|
      t.string :name
      t.integer :average_score
      t.integer :highest_score
      t.string :top_scorer
      t.string :top_player
      t.integer :top_player_points
      t.string :most_captained
      t.string :most_selected
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :completed
      t.boolean :is_next

      t.timestamps
    end
  end
end
