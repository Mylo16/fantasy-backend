class Api::V1::GameweeksController < ApplicationController
  before_action :set_gameweek, only: [:show, :update, :destroy]

  # GET /gameweeks
  def index
    @gameweeks = Gameweek.all
    render json: @gameweeks
  end

  # GET /gameweeks/:id
  def show
    render json: @gameweek
  end

  # POST /gameweeks
  def create
    @gameweek = Gameweek.new(gameweek_params)
    if @gameweek.save
      render json: @gameweek, status: :created
    else
      render json: @gameweek.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gameweeks/:id
  def update
    if @gameweek.update(gameweek_params)
      render json: @gameweek
    else
      render json: @gameweek.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gameweeks/:id
  def destroy
    @gameweek.destroy
  end

  private

  def set_gameweek
    @gameweek = Gameweek.find(params[:id])
  end

  def gameweek_params
    params.require(:gameweek).permit(:name, :average_score, :highest_score, :top_scorer, :most_captained, :start_date, :end_date)
  end
end
