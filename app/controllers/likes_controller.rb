class LikesController < ApplicationController

  def create
    video = Video.find(params[:video_id])
    current_user.likes.create(video: video)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button_#{video.id}", partial: "videos/like_button", locals: { video: video }) }
    end
  end

  def destroy
    video = Video.find(params[:video_id])
    like = current_user.likes.find_by(video: video)
    like&.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("like_button_#{video.id}", partial: "videos/like_button", locals: { video: video }) }
    end
  end
end
