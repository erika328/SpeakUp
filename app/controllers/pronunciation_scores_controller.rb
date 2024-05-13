class PronunciationScoresController < ApplicationController
  def create
    @pronunciation_score = current_user.pronunciation_scores.new(pronunciation_score_params)
    if @pronunciation_score.save
      render json: @pronunciation_score, status: :created
    else
      render json: @pronunciation_score.errors, status: :unprocessable_entity
    end
  end

  private

  def pronunciation_score_params
    params.require(:pronunciation_score).permit(:accuracy_score, :pronunciation_score, :fluency_score, :completeness_score, :pronunciation_text_id)
  end
end
