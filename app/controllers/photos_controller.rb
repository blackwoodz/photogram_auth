class PhotosController < ApplicationController
  def index
    @photos = Photo.order(created_at: :desc)
    @like_ids = Hash.new
    @photos.each do |photo|
      if photo.fan_list.include?(current_user.username)
        @like_ids[photo.id] = Like.where('user_id = ' + current_user.id.to_s + ' AND photo_id = ' + photo.id.to_s).take.id
      end
    end
    render("photos/index.html.erb")
  end

  def show
    @photo = Photo.find(params[:id])

    if @photo.fan_list.include?(current_user.username)
      @current_user_like_id = Like.where('user_id = ' + current_user.id.to_s + ' AND photo_id = ' + @photo.id.to_s).take.id
    end

    render("photos/show.html.erb")
  end

  def new
    @photo = Photo.new

    render("photos/new.html.erb")
  end

  def create
    @photo = Photo.new

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.user_id = params[:user_id]

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/#{@photo.id}", :notice => "Photo created successfully.")
    else
      render("photos/new.html.erb")
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    if @photo.user.id != current_user.id
      redirect_to("/photos/#{@photo.id}", :alert => "You are not authorized to edit this photo.")
    else
      render("photos/edit.html.erb")
    end
  end

  def update
    @photo = Photo.find(params[:id])

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.user_id = params[:user_id]

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/#{@photo.id}", :notice => "Photo updated successfully.")
    else
      render("photos/edit.html.erb")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user.id != current_user.id
      redirect_to("/photos/#{@photo.id}", :notice => "You are not authorized to delete this photo.")
    else
      @photo.destroy

      if URI(request.referer).path == "/photos/#{@photo.id}"
        redirect_to("/", :notice => "Photo deleted.")
      else
        redirect_to(:back, :notice => "Photo deleted.")
      end
    end
  end
end
