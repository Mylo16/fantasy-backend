class CreateFixtures < ActiveRecord::Migration[7.2]
  def change
    create_table :fixtures do |t|
      t.datetime :date
      t.json :stats
      t.boolean :completed

      t.timestamps
    end
  end
end
