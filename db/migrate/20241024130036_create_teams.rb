class CreateTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :short_name
      t.integer :strength
      t.string :code
      t.string :wins
      t.string :losses
      t.string :draws
      t.string :points

      t.timestamps
    end
  end
end
