class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
    @goal_chat = Goal.includes(messages: :user).find(params[:id])
    @milestones = @goal.milestones
    @milestone = Milestone.new
  end

  def create
    @goal = Goal.new()
    @goal.buddy = buddy_assign
    milestones = []
    @goal.milestones = milestones
    @milestone = Milestone.new
    @goal.start_date = Date.today








  end
end
