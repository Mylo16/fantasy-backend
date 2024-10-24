class CreateManagers < ActiveRecord::Migration[7.2]
  def change
    create_table :managers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :country
      t.integer :total_points
      t.integer :overall_rank
      t.string :password

      t.timestamps
    end
  end
end
