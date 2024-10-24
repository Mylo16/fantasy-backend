class Api::V1::MyTeamsController < ApplicationController
  before_action :set_my_team, only: [:add_player, :remove_player, :transfer_player]

  # Add a player to the fantasy team
  def add_player
    player = Player.find(params[:player_id])
    if @my_team.add_player(player)
      render json: { message: 'Player added successfully', team: @my_team.players }, status: :ok
    else
      render json: { error: @my_team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Remove a player from the fantasy team
  def remove_player
    player = Player.find(params[:player_id])
    if @my_team.remove_player(player)
      render json: { message: 'Player removed successfully', team: @my_team.players }, status: :ok
    else
      render json: { error: @my_team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Transfer a player (remove and add)
  def transfer_player
    old_player = Player.find(params[:old_player_id])
    new_player = Player.find(params[:new_player_id])
    if @my_team.transfer_player(old_player, new_player)
      render json: { message: 'Transfer successful', team: @my_team.players }, status: :ok
    else
      render json: { error: @my_team.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_my_team
    @fantasy_team = MyTeam.find(params[:id])
  end
end
