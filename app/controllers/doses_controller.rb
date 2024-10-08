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

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail), notice: 'Dose was successfully deleted.'
  end

  private

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end
