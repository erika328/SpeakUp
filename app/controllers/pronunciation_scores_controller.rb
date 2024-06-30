class PronunciationScoresController < ApplicationController
  def create
    @pronunciation_score = current_user.pronunciation_scores.new(pronunciation_score_params)
    if @pronunciation_score.save
      render json: @pronunciation_score, status: :created
    else
      render json: @pronunciation_score.errors, status: :unprocessable_entity
    end
  end

  def index
    @normal_texts = PronunciationText.for_user_and_difficulty(current_user, 'Normal')
    @hard_texts = PronunciationText.for_user_and_difficulty(current_user, 'Hard')
  end

  def show
    @pronunciation_text = PronunciationText.find(params[:id])
    @pronunciation_scores = @pronunciation_text.pronunciation_scores.where(user_id: current_user.id).page(params[:page]).per(20)
  end

  private

    def pronunciation_score_params
      params.require(:pronunciation_score).permit(:accuracy_score, :pronunciation_score, :fluency_score, :completeness_score, :pronunciation_text_id)
    end
end
