class UserFeelingsController < ApplicationController
  def show

  end

  def new
    @feelings = Feeling.all
    @user_feeling = UserFeeling.new
  end

  def create
    @user_feeling = UserFeeling.new(user_feeling_params)
    @user_feeling.user = current_user
    if @user_feeling.save!
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  private

  def user_feeling_params

  end
end
