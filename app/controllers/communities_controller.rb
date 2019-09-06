class CommunitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_community, only: :show

  def index
    @communities = current_user.communities
    @all_publications = []
    @communities.each do |community|
      community.publications.each { |pub| @all_publications << pub }
    end
    @all_publications.sort_by!(&:created_at)
  end

  def show
    @publication = Publication.new
    @users = @community.users
    @type = PublicationType.where(name: ['News', 'Question'])
    @community_publications = Publication.where(community: params[:id], publication_type: [@type[0].id, @type[1].id])
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end
end
