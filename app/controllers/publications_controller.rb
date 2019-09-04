class PublicationsController < ApplicationController

  def show
    @publication = Publication.find(params[:id])
  end

  def create
    @publication = Publication.new(user_feeling_params)
    raise
  end

  private

  def user_feeling_params
     params.require(:publication).permit(:title, :content, :community_id, :publication_type)
  end
end
