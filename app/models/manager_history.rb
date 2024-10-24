class ManagerHistory < ApplicationRecord
  belongs_to :manager
  belongs_to :gameweek
end
