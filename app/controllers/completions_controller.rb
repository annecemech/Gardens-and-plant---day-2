class CompletionsController < ApplicationController
  before_action :set_plant, only: [:new, :create]

  def new
    @completion = Completion.new
  end

  def create
    @completion = Completion.new(completion_params)
    @completion.plant = @plant
    if @completion.save
      redirect_to garden_path(@plant.garden)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @completion = Completion.find(params[:id])
    @completion.destroy
    redirect_to garden_path(@completion.plant.garden)
  end

  private

  def set_plant
    @plant = Plant.find(params[:plant_id])
  end

  def completion_params
    params.require(:completion).permit(:chore_id)
  end
end
