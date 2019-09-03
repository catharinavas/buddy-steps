class MilestonesController < ApplicationController
  def index
    @goal = Goal.find(params[:goal_id])
    @milestones = @goal.milestones
  end

  def new
    @milestone = Milestone.new
  end

  def create
    @milestone = Milestone.new(milestone_params)
    if @milestone.save
      redirect_to goal_path(goal)
    else
      render '/milestones/new'
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

  def delete
    @milestone = Milestone.find(params[:id])
    @consultation.destroy
    redirect_to goal_path(goal)
  end
end
