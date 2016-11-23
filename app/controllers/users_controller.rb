class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])

    @like_ids = Hash.new
    @user.photos.each do |photo|
      if photo.fan_list.include?(current_user.username)
        @like_ids[photo.id] = Like.where('user_id = ' + current_user.id.to_s + ' AND photo_id = ' + photo.id.to_s).take.id
      end
    end

  end

  def my_likes
  end

  def my_timeline
    @timeline_photos = current_user.timeline_photos.order("created_at DESC")

    @like_ids = Hash.new
    @timeline_photos.each do |photo|
      if photo.fan_list.include?(current_user.username)
        @like_ids[photo.id] = Like.where('user_id = ' + current_user.id.to_s + ' AND photo_id = ' + photo.id.to_s).take.id
      end
    end
  end
end
