class UsersController < ApplicationController
  def index
    @users = User.all
    @user_sidebar = User.find(current_user.id)
    @book_sidebar = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.reverse_order
    @user_sidebar = User.find(params[:id])
    @book_sidebar = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    # @user.id  = current_user.id
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
