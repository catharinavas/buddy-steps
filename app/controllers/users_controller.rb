class UsersController < ApplicationController
  before_action :set_user, only: :dashboard

  def dashboard
    #mood graph
    @options = set_graph_options
    @daily_series = set_daily_series

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

  def set_graph_options
    {
      title: 'Daily Mood',
      xtitle: 'Day',
      ytitle: 'Intensity',
      stacked: true
    }
  end

  def set_daily_series
    happ = Feeling.find_by(name: 'Happiness')
    happ_ary = current_user.user_feelings.where(feeling: happ)
    @happiness = {}
    happ_ary.each { |feel| @happiness[feel.feeling_date] = feel.intensity }

    caref = Feeling.find_by(name: 'Anxiety')
    # pat = Feeling.find_by(name: 'Irritability')
    # slp = Feeling.find_by(name: 'Sleep')

    @carefreeness = current_user.user_feelings.where(feeling: caref).group_by_day(:feeling_date).count
    # @patience = current_user.feelings.where(feeling: pat).group_by_day(:feeling_date)
    # @sleep = current_user.feelings.where(feeling: slp).group_by_day(:feeling_date)

    [
      { name: "General Happiness", data: @happiness },
      { name: "Carefreeness", data: @carefreeness }
    #   { name: "Patience", data: @patience },
    #   { name: "Sleep Quality", data: @sleep }
    ]
  end

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
