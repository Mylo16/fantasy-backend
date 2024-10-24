class LeagueParticipation < ApplicationRecord
  belongs_to :manager
  belongs_to :league
end
