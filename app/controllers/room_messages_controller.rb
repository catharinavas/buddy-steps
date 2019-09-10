class RoomMessagesController < ApplicationController
  def create
    @message = RoomMessage.new(message_params)
    @room = Room.find(params[:room_id])
    @message.room_id = @room.id
    @message.user = current_user

    if @message.save
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
  end

  private
  def message_params
    params.require(:room_message).permit(:content)
  end
end
