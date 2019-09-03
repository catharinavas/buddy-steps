class CommunitiesController < ApplicationController
  def index
    @communities = current_user.communities
    @all_publications = []
    @communities.each do |community|
      community.publications.each { |pub| @all_publications << pub }
    end
  end
end
