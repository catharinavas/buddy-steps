class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :completed, :confirm_buddy, :cancel_buddy]

  def show
    @goal_chat = Goal.includes(messages: :user).find(params[:id])
    @milestones = @goal.milestones
    @milestone = Milestone.new
    if current_user == @goal.buddy || current_user == @goal.user
      render 'show'
    else
      redirect_to user_path(@goal.user)
    end
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.buddy = buddy_assign
    @goal.start_date = Date.today
    @goal.user = current_user
    unless params[:goal][:category_id] == ""
      @goal.category = Category.find(params[:goal][:category_id])
    else
      @goal.category = Category.find_by(name: "Other")
    end
    if @goal.save
      redirect_to goal_path(@goal)
    else
      flash[:notice] = 'Invalid parameters!'
      redirect_to dashboard_path
    end
  end

  def edit
  end

  def update
    if @goal.update!(goal_params)
      redirect_to goal_path(@goal)
    else
      render 'edit'
    end
  end

  def destroy
    @goal.destroy
    redirect_to dashboard_path
  end

  def completed
    @goal.complete = @goal.complete ? false : true
    @goal.save
    redirect_to goal_path(@goal)
  end

  def buddy_assign
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
    @goal.confirmed_buddy = true
    @goal.save
    redirect_to goal_path(@goal)
  end

  def cancel_buddy
    buddy_assign
    redirect_to dashboard_path
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :deadline, :category)
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end
end
