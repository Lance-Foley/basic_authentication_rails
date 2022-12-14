class PostsController < ApplicationController
  before_action :valid_user_presence, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @user = User.find_by(id: session[:user_id])
    @posts = Post.all
  end
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      flash[:alert] = "Couldn't create the Post!"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to post_path, status: :see_other
  end

  def correct_user
    @post = Post.find(params[:id])
    @user = User.find_by(id: session[:user_id])
    if @user.id != @post.user_id
      redirect_to posts_path
      flash[:notice] = "You are not authorized to edit that post"
    end
  end
  private

  def set_post
    @post = Post.find(params[:id])

  end

  def post_params
    params.require(:post).permit(:title,:body,:user_id)
  end
end
