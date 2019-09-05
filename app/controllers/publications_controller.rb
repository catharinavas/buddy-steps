class PublicationsController < ApplicationController

  def show
    @publication = Publication.find(params[:id])
  end

  def create
    @publication = Publication.new(user_feeling_params)
    @community = Community.find(params[:publication][:community_id].to_i)

    @publication.community = @community
    @publication.user = current_user
    if @publication.save
      redirect_to community_path(@community)
    else
      render :community
    end
  end

  private

  def user_feeling_params
     params.require(:publication).permit(:title, :content, :community_id, :publication_type_id)
  end
end
