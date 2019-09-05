class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
    @goal_chat = Goal.includes(messages: :user).find(params[:id])
    @milestones = @goal.milestones
    @milestone = Milestone.new
    @buddies_goal = Goal.where(buddy_id: current_user)
  end

  def create
    @goal = Goal.new()
    @goal.buddy = buddy_assign
    milestones = []
    @goal.milestones = milestones
    @milestone = Milestone.new
    @goal.start_date = Date.today
  end

  def buddy_assign
    @goal = Goal.find(params[:id])
    city = current_user.city
    users_from_city = User.where("city = '#{city}'")
    if users_from_city.empty?
      possible_buddy = User.where.not(id: current_user).sample
    else
      possible_buddy = users_from_city.sample
    end
    @goal.buddy = possible_buddy
    @goal.save
  end

  def confirm_buddy
    @goal = Goal.find(params[:id])
    @goal.confirmed_buddy = true
    @goal.save
    redirect_to goal_path(@goal)
  end

  def cancel_buddy
    @goal = Goal.find(params[:id])
    buddy_assign
    redirect_to dashboard_path(current_user)
  end
end
