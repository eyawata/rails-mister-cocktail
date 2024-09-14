class CocktailsController < ApplicationController

  def index
    @cocktails = Cocktail.all

    # create a new cocktail
    @new_cocktail = Cocktail.new
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to @cocktail
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.doses.destroy_all
    @cocktail.destroy
    redirect_to cocktails_path, notice: 'Cocktail was successfully deleted.'
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end
