class RoomsController < ApplicationController
  before_action :set_user

  def index
    @new_room = Room.new
  end

  def create
    room = @user.rooms.create
    redirect_to room_path(room.base)
  end

  def show
    @room = Room.find_by(base: params[:base])
  end
end
