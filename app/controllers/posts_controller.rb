class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  def index
    if current_user
      @posts = Post.order(created_at: :desc).page(params[:page]).per(5)
    else
      redirect_to new_user_session_path
    end
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_back(fallback_location: root_path)  
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user)
  end

  def post_params
    params.require(:post).permit(:description, :image, :user_id)
  end

end