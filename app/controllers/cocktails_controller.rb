class CocktailsController < ApplicationController
  # resources :cocktails, only: [:index, :show, :edit, :new, :create]

  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def new
    newCocktail = Cocktail.new
    raise
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
