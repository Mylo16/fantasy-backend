class Fixture < ApplicationRecord
  belongs_to :gameweek
  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'

  validates :gameweek_id, :home_team, :away_team, :date, presence: true
end
