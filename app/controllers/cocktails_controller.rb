class CocktailsController < ApplicationController
  # resources :cocktails, only: [:index, :show, :edit, :new, :create]

  def index
    @cocktails = Cocktail.all

    # create a new cocktail
    @new_cocktail = Cocktail.new
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @dose = @cocktail.doses.new(dose_params)
    if @dose.save
      redirect_to @cocktail
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to @cocktail
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

  def dose_params
    params.require(:dose).permit(:ingredient_id, :description)
  end
end
