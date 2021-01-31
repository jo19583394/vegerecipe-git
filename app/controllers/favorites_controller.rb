class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    if @recipe.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, recipe_id: @recipe.id)
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = Favorite.find_by(user_id: current_user.id, recipe_id: @recipe.id)
    @favorite.destroy
  end
end
