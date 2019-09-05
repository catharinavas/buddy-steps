class GoalsController < ApplicationController
  def show
    @goal = Goal.find(params[:id])
    @goal_chat = Goal.includes(messages: :user).find(params[:id])
    @milestones = @goal.milestones
    @milestone = Milestone.new
  end

  def create
    @goal = Goal.new(goal_params)
    # @milestone = Milestone.new
    @goal.buddy = buddy_assign
    @goal.start_date = Date.today
    @goal.user = current_user
    unless params[:goal][:category_id].nil?
      @goal.category = Category.find(params[:goal][:category_id])
    else
      @goal.category = Category.find_by(name: "Others")
    end
    if @goal.save
      redirect_to goal_path(@goal)
    else
      render 'goals/new_form'
    end
  end

  def buddy_assign
    # @goal = Goal.find(params[:id])
    city = current_user.city
    users_from_city = User.where("city = '#{city}'").where.not(id: current_user)
    if users_from_city.empty?
      possible_buddy = User.where.not(id: current_user).sample
    else
      possible_buddy = users_from_city.sample
    end
    possible_buddy
  end

  def confirm_buddy
    @goal = Goal.find(params[:id])
    @goal.confirmed_buddy = true
    @goal.save
  end

  def cancel_buddy
    @goal = Goal.find(params[:id])
    buddy_assign
  end
end

private

def goal_params
  params.require(:goal).permit(:title, :description, :deadline, :category)
end
