class PronunciationTextsController < ApplicationController
  def index
    gon.speech_api_key = ENV['SPEECH_KEY']
    gon.speech_region = ENV['SPEECH_REGION']
    @reference_text = PronunciationText.where(difficulty: 'Normal').order("RANDOM()")
    @reference_text_hard = PronunciationText.where(difficulty: 'Hard').order("RANDOM()")
    gon.reference_text = @reference_text.map { |text| { id: text.id, english: text.english_text, japanese: text.japanese_text, difficulty: text.difficulty }}
    gon.reference_text_hard = @reference_text_hard.map { |text| { id: text.id, english: text.english_text, japanese: text.japanese_text, difficulty: text.difficulty }}
  end
end
