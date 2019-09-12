class RoomsController < ApplicationController

  def index
    @rooms = Room.where(user: current_user).or(Room.where(partner: current_user))
    if @rooms.size > 0
      @room = @rooms.first
      @room_chat = Room.includes(room_messages: :user).find(@room.id)
    end

  end

  def show
    @rooms = Room.where(user: current_user).or(Room.where(partner: current_user))
    @room_chat = Room.includes(room_messages: :user).find(params[:id])
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new
    @room.user = current_user
    partner = User.find(params[:format].to_i)
    @room.partner = partner
    old_rooms = Room.where(user: current_user, partner: partner).or(Room.where(user: partner, partner: current_user))

    if old_rooms.count.positive? || current_user == partner
      redirect_to room_path(old_rooms.first)
    else
      @room.name = "#{current_user.first_name} & #{@room.partner.first_name}"
      @room.save!
      redirect_to room_path(@room)
    end
  end
end
