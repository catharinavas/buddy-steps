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
    @milestones = @goal.milestones
    if @milestone.save
      respond_to do |format|
        format.html { redirect_to goal_path(@goal) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render '/goals/show' }
        format.js
      end
    end
  end

  def edit
    @milestone = Milestone.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    @goal = Goal.find(params[:goal_id])
    @milestone = Milestone.find(params[:id])
    if @milestone.update!(milestone_params)
      redirect_to dashboard_path(current_user)
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
