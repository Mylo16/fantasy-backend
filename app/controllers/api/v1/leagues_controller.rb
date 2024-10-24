class ClassicLeaguesController < ApplicationController
  before_action :set_league, only: [:show, :update, :destroy]

  # GET /leagues
  def index
    @leagues = League.all
    render json: @leagues
  end

  # GET /leagues/:id
  def show
    render json: @league
  end

  # POST /leagues
  def create
    @league = current_manager.created_leagues.new(league_params)
    if @league.save
      render json: @league, status: :created
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  def join
    @league = League.find(params[:id])
    current_manager.participating_leagues << @league
    redirect_to @league, notice: "Successfully joined the league!"
  end

  # PATCH/PUT /leagues/:id
  def update
    if @league.update(league_params)
      render json: @league
    else
      render json: @league.errors, status: :unprocessable_entity
    end
  end

  # DELETE /leagues/:id
  def destroy
    @league.destroy
  end

  private

  def set_league
    @league = League.find(params[:id])
  end

  def league_params
    params.require(:league).permit(:league_name, :league_type)
  end
end
