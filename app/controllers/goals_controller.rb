class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
    @goal_chat = Goal.includes(messages: :user).find(params[:id])
    @milestones = @goal.milestones
    @milestone = Milestone.new
  end

  def new
    @goal = Goal.new
    milestones = []
    @goal.milestones = milestones
    @milestone = Milestone.new
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
    confirmed_buddy = true
    @goal.save
  end

  def cancel_buddy
    @goal = Goal.find(params[:id])
    buddy_assign
  end
end
