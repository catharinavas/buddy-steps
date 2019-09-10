class RoomMessagesController < ApplicationController
  def create
    @room_message = RoomMessage.new(message_params)
    @room = Room.find(params[:room_id])
    @room_message.room = @room
    @room_message.user = current_user

    if @room_message.save
      respond_to do |format|
        format.html {redirect_to room_path(@room)}
        format.js
      end
    else
      respond_to do |format|
        format.html {render "rooms/show"}
        format.js
    end
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
