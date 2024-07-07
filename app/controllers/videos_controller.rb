class VideosController < ApplicationController
  before_action :permit_search_params, only: :index
  protect_from_forgery except: :track_shadowing

  def index
    @q = Video.ransack(params[:q])
    @videos = @q.result(distinct: true)

    if params[:q] && params[:q][:liked_by_user] == 'true'
      @saved_videos_exist = current_user.likes.exists?(video_id: @videos.pluck(:id))
      @videos = @videos.liked_by_user(current_user)
    else
      @saved_videos_exist = false
    end

    @videos = @videos.includes(:likes).page(params[:page]).per(12)

    if @videos.out_of_range? && params[:page].to_i != 1
      redirect_to videos_path(page: 1, q: params[:q]) and return
    end
  end

  def show
    @video = Video.includes(:likes).find(params[:id])
    @user_words = current_user.words.where("LOWER(english_word) IN (?)", @video.transcript.content.split(/\W+/).map(&:downcase))
  end

  def track_shadowing
    if params[:event] == 'video_played'
      today = Date.current
      activity_exists = Activity.exists?(user: current_user, action_type: 'shadowing_practice', created_at: today.beginning_of_day..today.end_of_day)

      unless activity_exists
        Activity.create(user: current_user, action_type: 'shadowing_practice')
      end

      render json: { status: 'success' }
    else
      render json: { status: 'invalid event' }, status: :unprocessable_entity
    end
  end

  private

    def permit_search_params
      params[:q] ||= { difficulty_eq: 'Beginner' }
      params[:q] = params.require(:q).permit(:difficulty_eq, :liked_by_user) if params[:q].present?
    end
end
