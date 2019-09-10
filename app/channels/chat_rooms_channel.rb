class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "room_#{params[:room_id]}"
  end
end
