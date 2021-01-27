class RecipesController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients = @recipe.recipe_ingredients.all
    @how_to_makes = @recipe.how_to_makes.all
  end

  def new
    @recipe = Recipe.new
    @recipe_ingredients = @recipe.recipe_ingredients.build
    @how_to_makes = @recipe.how_to_makes.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = 'レシピを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'レシピの投稿に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def search
    @recipes = Recipe.search(params[:keyword]).page(params[:page]).per(30)
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :catchcopy, :no_of_dish, :image, 
                                  recipe_ingredients_attributes:[:id, :recipe_id, :ing_name, :quantity, :_destroy],
                                  how_to_makes_attributes:[:id, :explanation, :process_image, :order_no, :_destroy])
  end
end
