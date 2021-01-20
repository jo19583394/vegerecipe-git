class RecipesController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
    @how_to_makes = @recipe.how_to_makes.build
  end

  def create
    @recipe = Recipe.new(recipe_params_ingredient)
    if @recipe.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def recipe_params_ingredient
    params.require(:recipe).permit(:title, :catchcopy, :no_of_dish, :image, 
                                  recipe_ingredients_attributes:[:id, :recipe_id, :ing_name, :quantity, :_destroy],
                                  how_to_makes_attributes:[:explanation, :process_image, :order_no, :_destroy])
  end
end
