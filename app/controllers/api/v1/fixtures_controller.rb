class Api::V1::FixturesController < ApplicationController
  before_action :set_fixture, only: [:show, :update, :destroy]

  # GET /fixtures
  def index
    @fixtures = Fixture.all
    render json: @fixtures
  end

  # GET /fixtures/:id
  def show
    render json: @fixture
  end

  # POST /fixtures
  def create
    @fixture = Fixture.new(fixture_params)
    if @fixture.save
      render json: @fixture, status: :created
    else
      render json: @fixture.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /fixtures/:id
  def update
    if @fixture.update(fixture_params)
      render json: @fixture
    else
      render json: @fixture.errors, status: :unprocessable_entity
    end
  end

  # DELETE /fixtures/:id
  def destroy
    @fixture.destroy
  end

  private

  def set_fixture
    @fixture = Fixture.find(params[:id])
  end

  def fixture_params
    params.require(:fixture).permit(:gameweek_id, :home_team, :away_team, :date, :stats)
  end
end
