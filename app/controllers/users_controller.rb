class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :update]
  after_action :verify_authorized, only: [:index, :update]

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.friendly.find(params[:id])
    authorize @user
    @posts = @user.posts.order(created_at: :desc)
  end

  def update
    @user = User.friendly.find(params[:id])
    authorize @user
    if @user.update(user_params)
      flash[:success] = 'User has been updated.'
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:admin)
  end
end
