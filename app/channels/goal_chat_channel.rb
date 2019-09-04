class GoalChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "goal_#{params[:goal_id]}"
  end
end
