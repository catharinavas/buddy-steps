class CommentsController < ApplicationController
  def create
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.new(comment_params)
    @comment.publication = @publication
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to publication_path(@publication) }
        format.json
      end
    else
      respond_to do |format|
        format.html { render 'publications/show' }
        format.json
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
