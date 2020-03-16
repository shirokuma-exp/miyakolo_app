class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  
  def index
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    @my_ranks = @all_ranks.select{ |post| post.user_id == current_user.id }
  end

  def edit
  end

  def update
    current_user.update(user_params)
    redirect_to current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :website, :bio, :email, :phone, :gender, :avatar)
  end
end