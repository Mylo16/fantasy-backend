class CreateManagerHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :manager_histories do |t|
      t.integer :points_scored
      t.string :chips_used
      t.integer :previous_rank

      t.timestamps
    end
  end
end
