class MilestonesController < ApplicationController
  def index
    @goal = Goal.find(params[:id])
    @milestones = @goal.milestones
  end

  def new
    @goal = Goal.find(params[:goal_id])
    @milestone = Milestone.new
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @milestone = Milestone.new(milestone_params)
    @milestone.goal_id = @goal.id
    if @milestone.save
      redirect_to goal_path(@goal)
    else
      render '/goals/show'
    end
  end

  def edit
    @milestone = Milestone.find(params[:id])
  end

  def update
    @milestone = Milestone.find(params[:id])
    if @milestone.update(milestone_params)
      redirect_to @goal
    else
      render 'edit'
    end
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy
    redirect_to goal_path
  end

  private

  def milestone_params
    params.require(:milestone).permit(:description, :deadline)
  end

end
