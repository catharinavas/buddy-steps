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
      respond_to do |format|
        format.html { redirect_to community_path(@community) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render "publications/news" }
        format.js  # <-- idem
      end
    end
  end

  private

  def user_feeling_params
     params.require(:publication).permit(:title, :content, :community_id, :publication_type_id)
  end
end
