class CreateMyTeams < ActiveRecord::Migration[7.2]
  def change
    create_table :my_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
