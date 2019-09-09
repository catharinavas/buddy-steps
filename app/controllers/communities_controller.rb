class CommunitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_community, only: %i[show join_community leave_community]




  def index
    @communities = Community.where.not(name: current_user.communities.pluck(:name))
    @all_publications = []
    @communities.each do |community|
      community.publications.each { |pub| @all_publications << pub }
    end
    @all_publications.sort_by!(&:created_at)
  end

  def show
    # Publication.reindex
    @publication = Publication.new
    @type = PublicationType.where(name: ['News', 'Question'])

    if params[:query].present?
      @community_publications = Publication.where(community: params[:id], publication_type: [@type[0].id, @type[1].id])
      @community_publications = @community_publications.global_search(params[:query])
    else
      @community_publications = Publication.where(community: params[:id], publication_type: [@type[0].id, @type[1].id])
    end

    @users = @community.users
  end

  def join_community
    CommunityUser.create(user: current_user, community: @community)
    redirect_to community_path(@community)
  end

  def leave_community
    CommunityUser.all.where(user: current_user, community: @community).destroy_all
    redirect_to communities_path
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end
end
