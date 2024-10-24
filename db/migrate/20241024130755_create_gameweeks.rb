class CreateGameweeks < ActiveRecord::Migration[7.2]
  def change
    create_table :gameweeks do |t|
      t.string :name
      t.integer :average_score
      t.integer :highest_score
      t.string :top_scorer
      t.string :most_captained
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
