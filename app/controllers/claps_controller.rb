class ClapsController < ApplicationController
  def new
    @publication = Publication.find(params[:publication_id])
    @clap = Clap.find_by(user: current_user, publication: @publication)

    # if @clap.nil?
    #   Clap.create!(user: current_user, publication: @publication)
    # else
    #   @clap.destroy
    # end
    respond_to do |format|
      format.html { redirect_to communities_path }
      format.js
    end
    # redirect_to communities_path
  end

  def update
  end
end
