class UsersController < ApplicationController
  before_action :set_user, only: :dashboard

  def dashboard
    @user = User.find(params[:id])
    @moods = UserFeeling.where(user: params[:id])
    # GOALS DATA
    @goals = Goal.where(user: params[:id])

  end
  
  def show
  end

  private

  def user_params
    # params.require(:user).permit()
  end
    
  def set_user
    @user = User.find(params[:id])
  end
end
