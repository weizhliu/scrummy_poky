class RoomsController < ApplicationController
  before_action :set_user
  before_action :set_room, only: %i[show reveal restart]

  def index
    @new_room = Room.new
  end

  def create
    room = @user.rooms.create
    redirect_to room_path(room.base)
  end

  def show; end

  def reveal
    @room.end!
    @room.cards.each(&:reveal!)
  end

  def restart
    @room.open!
    @room.cards.destroy_all
  end

  private

  def set_room
    @room = Room.find_by(base: params[:base])
  end
end
