class VideosController < ApplicationController
  before_action :permit_search_params, only: :index
  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(distinct: true)

    if params[:q] && params[:q][:liked_by_user] == 'true'
      @saved_videos_exist = current_user.likes.exists?(video_id: @videos.pluck(:id))
      @videos = @videos.liked_by_user(current_user)
    else
      @saved_videos_exist = false
    end

    @videos = @videos.page(params[:page]).per(12)

    if @videos.out_of_range? && params[:page].to_i != 1
      redirect_to videos_index_path(page: 1, q: params[:q]) and return
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def permit_search_params
    params[:q] = params.require(:q).permit(:difficulty_eq, :liked_by_user) if params[:q].present?
  end
end
