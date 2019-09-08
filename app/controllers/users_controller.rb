class UsersController < ApplicationController
  before_action :set_user, only: :dashboard

  def dashboard

    # user feelings
    @user_feeling = UserFeeling.new # new feeling

    @user_feelings = today_feeling
    if @user_feelings == []
      @feelings = Feeling.all
    else
      @feelings = Feeling.where.not(id: @user_feelings.pluck(:feeling_id))
    end


    @user = User.find(params[:id])
    @moods = UserFeeling.where(user: params[:id])

    # GOALS DATA
    @my_goals = Goal.where(user: params[:id])
    @buddies_goals = Goal.where(buddy_id: current_user)

    # MODAL NEW GOAL
    @goal = Goal.new
    @milestone = Milestone.new

    # PUBLICATIONS
    diary_publication_types = PublicationType.where(name: ['Frustration', 'Pleasure', 'Celebration'])
    @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
    @communities = nil

    # BUDDY NOTIFICATION

  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    # params.require(:user).permit()
  end

  def set_user
    @user = User.find(params[:id])
  end

  def today_feeling
    UserFeeling.where(user: current_user, feeling_date: Date.today)
  end
end
