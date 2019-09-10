class RoomsController < ApplicationController

  def create
    @room = Room.new
    @room.user = current_user
    @room.partner = User.find(params[:id])
    @room.name = "#{current_user.first_name} & #{@room.partner.first_name}"
    raise
    @room.save!


  end

  def show
    @room_chat = Room.includes(room_messages: :user).find(params[:id])
    @room = Room.find(params[:id])
  end
end
