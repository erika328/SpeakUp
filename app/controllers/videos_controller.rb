class VideosController < ApplicationController
  before_action :permit_search_params, only: :index
  def index
    @q = Video.ransack(params[:q])
    if params[:q] && params[:q][:liked_by_user] == 'true'
      @videos = @q.result(distinct: true).liked_by_user(current_user).page(params[:page]).per(12)
    else
      @videos = @q.result(distinct: true).page(params[:page]).per(12)
    end

    if @videos.out_of_range?
      redirect_to videos_index_path(page: @videos.total_pages, q: params[:q])
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
