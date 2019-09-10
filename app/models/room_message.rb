class RoomMessage < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true, allow_blank: false
  after_create :broadcast_message

  def from?(some_user)
    user == some_user
  end

    def broadcast_message
    ActionCable.server.broadcast("chat_room_#{room.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/message",
        locals: { message: self, user_is_messages_author: false }
      ),
      current_user_id: user.id
    })
  end

end
