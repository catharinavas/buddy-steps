class UsersController < ApplicationController
  before_action :set_user, only: :dashboard

  def dashboard
    @new_feeling = UserFeeling.new # new feeling

    @last_feeling = current_user.user_feelings.last

    @moods = UserFeeling.where(user: params[:id])

    # GOALS DATA
    @my_goals = Goal.where(user: current_user)
    @buddies_goals = Goal.where(buddy_id: current_user)

    # MODAL NEW GOAL
    @goal = Goal.new
    @milestone = Milestone.new

    # QUANTITY OF INCOMPLETED GOALS
    @incompleted_goals = Goal.where(user: current_user).where(complete: false)

    # PUBLICATIONS
    diary_publication_types = PublicationType.where(name: ['Frustration', 'Pleasure', 'Celebration'])
    @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
    @communities = nil

    # BUDDY NOTIFICATION
  end

  def show
    @user = User.find(params[:id])

    # GOALS
    @completed_goals = Goal.where(user: @user).where(complete: true)
    @my_goals = Goal.where(user: current_user)

    # PUBLICATIONS
    diary_publication_types = PublicationType.where(name: ['Frustration', 'Pleasure', 'Celebration'])
    @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
    @communities = nil

  end

  private

  def user_params
    # params.require(:user).permit()
  end

  def set_user
    @user = current_user
  end

  def today_feeling
    UserFeeling.where(user: current_user, feeling_date: Date.today)
  end
end
