class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
    @goal_chat = Goal.includes(messages: :user).find(params[:id])
    @milestones = @goal.milestones
    @milestone = Milestone.new
  end
end