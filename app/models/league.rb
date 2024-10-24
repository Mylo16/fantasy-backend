class League < ApplicationRecord
  # The manager who created the league (admin)
  belongs_to :admin_manager, class_name: 'Manager', foreign_key: 'manager_id'

  # Many managers can participate in the league
  has_many :league_participations
  has_many :managers, through: :league_participations
end
