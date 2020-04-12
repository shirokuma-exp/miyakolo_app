class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:follow_id])
    follow = current_user.follow!(@user)
    if follow.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to @user
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).follow
    follow = current_user.unfollow!(@user)
    if follow.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to @user
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to @user
    end
  end
end