class Api::V1::GeneralSummaryController < ApplicationController
  def index
    render json: {
      players: Player.all,
      gameweeks: Gameweek.all,
      teams: Team.all,
      total_participants: Manager.count
    }
end