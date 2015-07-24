class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def index
    @posts = Post.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post has been created.'
      redirect_to @post
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post has been updated.'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post has been deleted.'
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :teaser, :text)
  end

  def post_not_found
    flash[:alert] = 'Post not found.'
    redirect_to posts_path
  end
end
