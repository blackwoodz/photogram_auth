class LikesController < ApplicationController
  def index
    @likes = Like.all

    render("likes/index.html.erb")
  end

  def show
    @like = Like.find(params[:id])

    render("likes/show.html.erb")
  end

  def new
    @like = Like.new

    render("likes/new.html.erb")
  end

  def create
    @like = Like.new

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    save_status = @like.save

    if save_status == true
      redirect_to(:back, :notice => "Like created successfully.")
    else
      render("likes/new.html.erb")
    end
  end

  def edit
    @like = Like.find(params[:id])
    if @like.photo.user.id != current_user.id
      redirect_to("/photos/#{@photo.id}", :notice => "You are not authorized to change another user's like for this photo.")
    else
      render("likes/edit.html.erb")
    end
  end

  def update
    @like = Like.find(params[:id])

    @like.user_id = params[:user_id]
    @like.photo_id = params[:photo_id]

    save_status = @like.save

    if save_status == true
      redirect_to("/likes/#{@like.id}", :notice => "Like updated successfully.")
    else
      render("likes/edit.html.erb")
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.photo.user.id != current_user.id
      redirect_to("/photos/#{@photo.id}", :alert => "You are not delete another user's like for this photo.")
    else
      @like.destroy

      if URI(request.referer).path == "/likes/#{@like.id}"
        redirect_to("/", :notice => "Like deleted.")
      else
        redirect_to(:back, :notice => "Like deleted.")
      end
    end
  end
end
