class CommunitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_community, only: :show

  def show
    @users = @community.users
    @news = Publication.where(community: 1, publication_type: [1, 2])
    @celebrations = Publication.where(community: 1, publication_type: 3)
  end


  private

  def set_community
    @community = Community.find(params[:id])
  end
end
