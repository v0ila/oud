class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)
      if @recipe.save
    redirect_to @recipe, notice: 'Recept toevoegen voltooid' 
    else
      render 'new'
    end
  end


  def update

  end

  def destroy

  end
 
  private
    def recipe_params
      params.require(:recipe).permit(:title, :description)
    end
  end
