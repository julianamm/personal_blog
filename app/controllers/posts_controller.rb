class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
    # render json: @posts 
  end

  def create
    @post = Post.new post_params
    @post.user = current_user

    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    find_post
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:tittle, :body)
  end

  def find_post
    @post = Post.find params[:id]
  end
  def authorize_user!
    unless can?(:manage, @post)
      flash[:danger] = "Access Denied"
      redirect_to post_path(@post)
    end
  end
end
