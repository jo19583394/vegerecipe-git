class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :followings, :followers, :favorites]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "新規登録が完了しました。"
      redirect_to @user
    else
      flash.now[:danger] = "新規登録に失敗しました。"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to @user
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to @user
    else
      if @user.update(user_params)
        flash[:success] = "プロフィールを編集しました。"
        redirect_to @user
      else
        flash.now[:danger] = "プロフィールの編集に失敗しました。"
        render :edit
      end
    end
  end

  def destroy
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).page(params[:page]).pluck(:recipe_id)
    @favorites = Recipe.find(favorites)
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :profile_image)
  end
end
