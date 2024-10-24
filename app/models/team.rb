class Team < ApplicationRecord
  has_many :players
  has_many :fixtures_as_home_team, class_name: 'Fixture', foreign_key: 'home_team'
  has_many :fixtures_as_away_team, class_name: 'Fixture', foreign_key: 'away_team'

  validates :name, :short_name, :strength, :code, presence: true
end
