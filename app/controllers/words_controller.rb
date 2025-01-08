require_relative '../services/deep_l_translator'

class WordsController < ApplicationController
  def index
    @q = current_user.words.ransack(params[:q])
    @words = @q.result(distinct: true).includes(:user).page(params[:page]).per(20).order(created_at: :desc)
  end

  def new; end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      Activity.create(user: current_user, action_type: 'word_registration')
      respond_to do |format|
        format.html { redirect_to request.referer || word_path }
        format.json { render json: { success: true, message: "New word has been saved." }, status: :created }
      end
    else
      flash.now[:alert] = @word.errors.full_messages
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.json { render json: { success: false, errors: @word.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def show; end

  def edit
    @word = Word.find(params[:id])
    @words = current_user.words
  end

  def update
    @word = Word.find(params[:id])
    @words = current_user.words

    if @word.update(word_params)
      flash.notice = "Word has been updated."
      redirect_to words_path
    else
      # バリデーションエラー時にはedit.html.erbをrenderする
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy!
    redirect_to words_path, status: :see_other
    flash.notice = "Word was successfully destroyed."
  end

  def random
    @word = current_user.words.where('next_review_date IS NULL OR next_review_date <= ?', Time.zone.today).order('RANDOM()').first

    if @word.nil?
      flash[:notice] = "There's nothing to review!振り返る単語がありません。"
      redirect_to words_path
    end
    @words_due_today = current_user.words.due_today
    @words_count_due_today = @words_due_today.count
  end

  def update_review_status
    @word = current_user.words.find(params[:id])
    case params[:status]
    when 'easy'
      @word.update(review_status: 'easy', next_review_date: 5.days.from_now)
    when 'normal'
      @word.update(review_status: 'normal', next_review_date: 1.day.from_now)
    when 'hard'
      @word.update(review_status: 'hard', next_review_date: Time.zone.today) # 何度も表示
    end

    Activity.create(user: current_user, action_type: 'review_completed')
    redirect_to random_words_path
  end

  def translate_text
    api_key = ENV['DEEP_L_KEY']
    translator = DeepLTranslator.new(api_key)

    response = translator.translate(params[:text], 'JA') # params[:text] は選択した英単語
    if response.success?
      translated_text = response.parsed_response['translations'][0]['text']
      render json: { translated_text: }
    else
      render json: { error: "#{response.code} - #{response.message}" }, status: :unprocessable_entity
    end
  end

  private

    def word_params
      params.require(:word).permit(:english_word, :meaning, :example, :part_of_speech)
    end
end
