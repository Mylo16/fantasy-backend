class Api::V1::PlayersController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]
  def index
    @team = Team.find(params[:team_id])
    @players = @team.players
    render json: @players
  end

  def show
    @player = Player.find(params[:id])
    render json: @player
  end

  def create
    @team = Team.find(params[:team_id])
    @player = @team.players.build(player_params)
    if @player.save
      render json: @player, status: :created
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    head :no_content
  end

  private

  def player_params
    params.require(:player).permit(:first_name, :last_name, :position_id, :team_id, :total_points, :status, :value, :match_stats)
  end
end
