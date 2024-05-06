class VideosController < ApplicationController
  def index
    @videos = Video.all.page(params[:page]).per(12)
  end

  def show
    @video = Video.find(params[:id])
  end
end
