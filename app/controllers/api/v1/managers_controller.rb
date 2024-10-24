class Api::V1::ManagersController < ApplicationController
  before_action :set_manager, only: [:show, :update, :destroy]

  # GET /managers
  def index
    @managers = Manager.all
    render json: @managers
  end

  # GET /managers/:id
  def show
    render json: @manager
  end

  # POST /managers
  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      render json: @manager, status: :created
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /managers/:id
  def update
    if @manager.update(manager_params)
      render json: @manager
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  # DELETE /managers/:id
  def destroy
    @manager.destroy
  end

  private

  def set_manager
    @manager = Manager.find(params[:id])
  end

  def manager_params
    params.require(:manager).permit(:first_name, :last_name, :country, :total_points, :overall_rank, :email, :league_id)
  end
end
