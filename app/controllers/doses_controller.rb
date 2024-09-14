class DosesController < ApplicationController

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @cocktail.doses.new(dose_params)
    if @dose.save
      redirect_to @cocktail
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end
