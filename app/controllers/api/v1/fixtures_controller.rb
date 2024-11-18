class Api::V1::FixturesController < ApplicationController
  before_action :require_login, only: [:create, :update, :destroy]

  # GET /fixtures
  def index
    @gameweek = Gameweek.find(params[:gameweek_id])
    @fixtures = @gameweek.fixtures.includes(:stats)
    render json: @fixtures.to_json(include: :stats)
  end

  def show
    @fixture = Fixture.includes(:stats).find(params[:id])
    render json: @fixture.to_json(include: :stats)
  end

  def create
    @gameweek = Gameweek.find(params[:gameweek_id])
    @fixture = @gameweek.fixtures.build(fixture_params)
    if @fixture.save
      render json: @fixture, status: :created
    else
      render json: @fixture.errors, status: :unprocessable_entity
    end
  end

  def update
    @fixture = Fixture.find(params[:id])
    if @fixture.update(fixture_params)
      render json: @fixture
    else
      render json: @fixture.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @fixture = Fixture.find(params[:id])
    @fixture.destroy
    head :no_content
  end

  private

  def fixture_params
    params.require(:fixture).permit(
      :gameweek_id, :home_team, :away_team, :date,
      stats_attributes: [
        :identifier,
        :home_stats,
        :away_stats
      ]
    )
  end
end
