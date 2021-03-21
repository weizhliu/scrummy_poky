class RoomsController < ApplicationController
  before_action :set_user
  before_action :set_room, only: %i[show reveal restart]

  def index
    @new_room = Room.new
    @last_room = Room.find_by(id: @user.last_room)
  end

  def create
    room = @user.rooms.create
    redirect_to room_path(room.base)
  end

  def show
    @card = @room.cards.find_by(user: @user)
  end

  def reveal
    if @room.cards.empty?
      @room_message = '🤔 Pick a card first!'
      return render @room
    end
    @room.end!
    @room.cards.each(&:reveal!)
  end

  def restart
    @room.open!
    @room.cards.destroy_all
    Turbo::StreamsChannel.broadcast_replace_later_to(
      [@room, 'hand_reset'],
      target: 'hand',
      partial: 'rooms/hand', locals: { room: @room, card: nil }
    )
  end

  private

  def set_room
    @room = Room.find_by(base: params[:base])
  end
end
