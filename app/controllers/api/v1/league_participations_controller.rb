class LeagueParticipationsController < ApplicationController
  def create
    @league = League.find(params[:league_id])
    @participation = @league.league_participations.build(manager_id: params[:manager_id])
    if @participation.save
      render json: @participation, status: :created
    else
      render json: @participation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @participation = LeagueParticipation.find(params[:id])
    @participation.destroy
    head :no_content
  end
end
