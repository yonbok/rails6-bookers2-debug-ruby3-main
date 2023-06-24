class UsersController < ApplicationController
  #before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
     flash[:notice] = "Welcome! You have signed up successfully."
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
     redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def followings
    @user = User.find(params[:user_id])
    users = user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #def ensure_correct_user
   # @user = User.find(params[:id])
    #unless @user == current_user
      #redirect_to user_path(current_user)
    #end
  #end
end
