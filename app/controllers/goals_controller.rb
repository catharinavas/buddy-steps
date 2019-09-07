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
    unless params[:goal][:category_id] == ""
      @goal.category = Category.find(params[:goal][:category_id])
    else
      @goal.category = Category.find_by(name: "Other")
    end
    if @goal.save
      redirect_to goal_path(@goal)
    else
      flash[:notice] = 'Invalid parameters!'
      redirect_to dashboard_path(current_user)
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    # respond_to do |format|
    #   format.js
    # end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update!(goal_params)
      redirect_to goal_path(@goal)
    else
      render 'edit'
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to dashboard_path(current_user)
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
    redirect_to goal_path(@goal)
  end

  def cancel_buddy
    @goal = Goal.find(params[:id])
    buddy_assign
    redirect_to dashboard_path(current_user)
  end
end

private

def goal_params
  params.require(:goal).permit(:title, :description, :deadline, :category)
end
