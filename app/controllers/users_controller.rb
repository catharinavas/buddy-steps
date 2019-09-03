class UsersController < ApplicationController
  def dashboard
    # MOOD GRAPH DATA
    @moods = UserFeeling.where(user: params[:id])
  end

  private

  def user_params
    # params.require(:user).permit()
  end

end
