class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    video = Video.find(params[:video_id])
    current_user.likes.create(video: video)
    redirect_to request.referer
  end

  def destroy
    video = Video.find(params[:video_id])
    like = current_user.likes.find_by(video: video)
    like&.destroy
    redirect_to request.referer
  end
end
