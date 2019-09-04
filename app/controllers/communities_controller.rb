class CommunitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_community, only: :show

  def index
    @communities = current_user.communities
    @all_publications = []
    @communities.each do |community|
      community.publications.each { |pub| @all_publications << pub }
    end
  end

  def show
    @publication = Publication.new
    @users = @community.users
    @type1 = PublicationType.where(name: ['News', 'Questions'])
    @type2 = PublicationType.where(name: 'Celebrations')
    @news = Publication.where(community: params[:id], publication_type: [@type1[0].id, @type1[1].id])
    @celebrations = Publication.where(community: params[:id], publication_type: @type2[0].id)
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end
end
