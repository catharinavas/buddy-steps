class UsersController < ApplicationController
  def show
    # MOOD GRAPH DATA
    @user = User.find(params[:id])
    @moods = UserFeeling.where(user: params[:id])
  end

  private

  def user_params
    # params.require(:user).permit()
  end
end
