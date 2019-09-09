class PublicationsController < ApplicationController

  def show
    @publication = Publication.find(params[:id])
  end

  def create
    @publication = Publication.new(publication_params)
    @publication.user = current_user
    if params[:community_id]
      @community = Community.find(params[:publication][:community_id].to_i)
      @publication.community = @community
    end

    if @publication.save
        redirect_to publication_path(@publication)
    else
      if params[:community_id]
        flash[:notice] = 'Invalid parameters!'
        redirect_to community_path(params[:community_id])
      else
        flash[:notice] = 'Invalid parameters!'
        redirect_to dashboard_path
      end
    end
  end

  def destroy
    @publication = Publication.find(params[:id])

    @publication.community ? community = @publication.community : community = false

    @publication.destroy

    if community
      redirect_to community_path(community)
    else
      redirect_to dashboard_path
    end
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :content, :community_id, :publication_type_id, :photo)
  end
end
