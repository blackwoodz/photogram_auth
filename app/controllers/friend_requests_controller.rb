class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.all

    render("friend_requests/index.html.erb")
  end

  def show
    @friend_request = FriendRequest.find(params[:id])

    render("friend_requests/show.html.erb")
  end

  def new
    @friend_request = FriendRequest.new

    render("friend_requests/new.html.erb")
  end

  def create
    @friend_request = FriendRequest.new

    @friend_request.sender_id = params[:sender_id]
    @friend_request.receiver_id = params[:receiver_id]

    if(current_user.id != @friend_request.sender_id)
      redirect_to(:back, :alert => "You cannot create a friend request on someone else's behalf.")
    else
      save_status = @friend_request.save

      if save_status == true
        redirect_to(:back, :notice => "Friend request created successfully.")
      else
        render("friend_requests/new.html.erb")
      end
    end
  end

  def edit
    @friend_request = FriendRequest.find(params[:id])

    if(current_user.id != @friend_request.sender_id)
      redirect_to(:back, :alert => "You cannot update someone else's friend request.")
    else
      render("friend_requests/edit.html.erb")
    end
  end

  def update
    @friend_request = FriendRequest.find(params[:id])

    @friend_request.sender_id = params[:sender_id]
    @friend_request.receiver_id = params[:receiver_id]

    if(current_user.id != @friend_request.sender_id)
      redirect_to(:back, :alert => "You cannot update someone else's friend request.")
    else
      save_status = @friend_request.save

      if save_status == true
        redirect_to(:back, :notice => "Friend request updated successfully.")
      else
        render("friend_requests/edit.html.erb")
      end
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])

    if(current_user.id != @friend_request.sender_id)
      redirect_to(:back, :alert => "You cannot delete someone else's friend request.")
    else
      @friend_request.destroy

      if URI(request.referer).path == "/friend_requests/#{@friend_request.id}"
        redirect_to(:back, :notice => "Friend request deleted.")
      else
        redirect_to(:back, :notice => "Friend request deleted.")
      end
    end
  end
end
