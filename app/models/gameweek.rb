class Gameweek < ApplicationRecord
  has_many :fixtures

  validates :name :average_score, :highest_score, :top_scorer, :most_captained, :start_date, :end_date, presence: true
end
