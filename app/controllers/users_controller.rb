class UsersController < ApplicationController
  before_action :set_user, only: :dashboard

  def dashboard
    # MOOD GRAPH DATA
    @moods = UserFeeling.where(user: params[:id])
  end

  private

  def user_params
    # params.require(:user).permit()
  end

  def set_user
    @user = User.find(params[:id])
  end

end
