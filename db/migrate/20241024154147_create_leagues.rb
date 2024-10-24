class CreateLeagues < ActiveRecord::Migration[7.2]
  def change
    create_table :leagues do |t|
      t.string :league_name
      t.string :league_type

      t.timestamps
    end
  end
end
