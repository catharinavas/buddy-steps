class RoomController < ApplicationController
  def show
    @room = Room.includes(messages: :user).find(params[:id])
  end
end
