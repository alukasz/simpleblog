class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = current_user.posts.build
    authorize @post
  end

  def create
    @post = current_user.posts.create(post_params)
    authorize @post
    if @post.save
      flash[:success] = 'Post has been created.'
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      flash[:success] = 'Post has been updated.'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    flash[:success] = 'Post has been deleted.'
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :teaser, :text)
  end

  def post_not_found
    flash[:alert] = 'Post not found.'
    redirect_to posts_path
  end
end
