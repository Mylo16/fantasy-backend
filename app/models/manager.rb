class Manager < ApplicationRecord
  has_many :created_leagues, class_name: 'League', foreign_key: 'manager_id', dependent: :destroy
  has_many :manager_histories
  has_many :league_participations
  has_one :my_team
  has_many :participating_leagues, through: :league_participations, source: :league

  validates :first_name, :last_name, :country, :email, :password, :league_id, presence: true
end
