class PublicationsController < ApplicationController
  def show
    @publication = Publication.find(params[:id])
  end
end
