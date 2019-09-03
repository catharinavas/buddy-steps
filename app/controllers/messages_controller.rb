class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @goal_chat = Goal.find(params[:goal_id])
    @message.goal_id = @goal_chat.id
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.html { redirect_to goal_path(@goal_chat) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "goal/show" }
        format.js
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
