class VideosController < ApplicationController
  before_action :permit_search_params, only: :index
  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(distinct: true).page(params[:page]).per(16)
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def permit_search_params
    params[:q] = params.require(:q).permit(:difficulty_eq) if params[:q].present?
  end
end
