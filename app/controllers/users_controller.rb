class UsersController < ApplicationController
  before_action :set_user, only: :dashboard

  def dashboard
    # MOOD GRAPH
    @new_feeling = UserFeeling.new # new feeling
    @last_feeling = current_user.user_feelings.last
    if current_user.user_feelings.to_a.nil?
      @moods = UserFeeling.where(user: params[:id])

      @all_happiness_intensities = current_user.user_feelings.map(&:happiness)
      @streaks = @all_happiness_intensities.join.split('0')
      @current_streak = @streaks.last.size
      @longest_streak = @streaks.map(&:size).max
    end

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
    @communities = nil
    if params[:query].present?
      @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
      @diary_publications = @diary_publications.profile_search(params[:query])
    else
      @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
    end
    # BUDDY NOTIFICATION
  end

  def show
    @user = User.find(params[:id])

    # GOALS
    @completed_goals = Goal.where(user: @user).where(complete: true)
    @my_goals = Goal.where(user: @user)

    # PUBLICATIONS
    diary_publication_types = PublicationType.where(name: ['Frustration', 'Pleasure', 'Celebration'])
    @communities = nil

    if params[:query].present?
      @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
      @diary_publications = @diary_publications.profile_search(params[:query])
    else
      @diary_publications = current_user.publications.where(publication_type: diary_publication_types)
    end

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
