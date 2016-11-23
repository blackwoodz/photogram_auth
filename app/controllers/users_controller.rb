class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
  end

  def my_likes
  end

  def my_timeline
    @timeline_photos = current_user.timeline_photos.order("created_at DESC")
  end
end
