class ToppagesController < ApplicationController
  def index
    @recipes = Recipe.all.order(created_at: :desc).limit(8)
    @recipe_ranks = Recipe.find(Favorite.group(:recipe_id).order("count(recipe_id) desc").limit(8).pluck(:recipe_id))
  end
end
