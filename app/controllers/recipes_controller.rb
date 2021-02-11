class RecipesController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @recipes = Recipe.order(id: :desc).page(params[:page])
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
    @recipe.user_id = current_user.id
    
    if @recipe.save
      flash[:success] = 'レシピを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'レシピの投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    unless @recipe.user == current_user
      redirect_to @recipe
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to @recipe
    else
      if @recipe.update(recipe_params)
        flash[:success] = "レシピを編集しました。"
        redirect_to @recipe
      else
        flash.now[:danger] = "レシピ編集に失敗しました。"
        render :edit
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:success] = "レシピを削除しました。"
      redirect_to user_path(@recipe.user)
    else
      flash.now[:danger] = "レシピ削除に失敗しました。"
    end
  end
  
  def search
    @recipes = Recipe.search(params[:keyword]).page(params[:page]).per(30)
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :catchcopy, :no_of_dish, :image, 
                                  recipe_ingredients_attributes:[:id, :recipe_id, :ing_name, :quantity, :_destroy],
                                  how_to_makes_attributes:[:id, :explanation, {process_image: []}, :_destroy])
  end
end
