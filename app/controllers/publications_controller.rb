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
      respond_to do |format|
        format.html { redirect_to publication_path(@publication) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render "publications/news" } if params[:community_id]
        # PRECISA FAZERUM REDIRECIONAMENTO HTML PARA DIARY TAMBÉM!!!!
        format.js  # <-- idem
      end
    end
  end

  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy!
    redirect_to dashboard_path
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :content, :community_id, :publication_type_id)
  end
end
