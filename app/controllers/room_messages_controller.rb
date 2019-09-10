class RoomMessagesController < ApplicationController
  def create
    @room_message = RoomMessage.new(message_params)
    @room_chat = Room.find(params[:room_id])
    @room_message.room_id = @room_chat.id
    @room_message.user = current_user

    if @room_message.save
      respond_to do |format|
        format.html { redirect_to room_path(@room_chat) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "rooms/show" }
        format.js
      end
    end
  end

  private
  def message_params
    params.require(:room_message).permit(:content)
  end
end
