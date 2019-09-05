class CommentsController < ApplicationController
  def create
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.new(comment_params)
    @comment.publication = @publication
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        puts 'saved'
        format.html { redirect_to publication_path(@publication) }
        format.js
      end
    else
      respond_to do |format|
        puts 'not saved'
        format.html { render 'publications/show' }
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @publication = @comment.publication
    @comment.destroy!
    redirect_to publication_path(@publication)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
