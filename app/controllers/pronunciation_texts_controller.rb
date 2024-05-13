class PronunciationTextsController < ApplicationController
  def show
    gon.speech_api_key = ENV['SPEECH_KEY']
    gon.speech_region = ENV['SPEECH_REGION']
    @reference_text = PronunciationText.order("RANDOM()").limit(3)
    gon.reference_text = @reference_text.map { |text| { id: text.id, english: text.english_text, japanese: text.japanese_text, difficulty: text.difficulty }}
  end
end
