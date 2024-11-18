class Player < ApplicationRecord
  belongs_to :team
  belongs_to :position
  has_many :fixtures, through: :team
  has_and_belongs_to_many :my_teams
  has_many :stat_details

  validates :first_name, :last_name, :team_id, :position_id, :total_points, :status, :value, presence: true

end
