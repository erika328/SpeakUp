class WordsController < ApplicationController
  def index
    @q = current_user.words.ransack(params[:q])
    @words = @q.result(distinct: true).includes(:user).page(params[:page]).per(20).order(created_at: :desc)
    @word = Word.new
  end

  def new
    @word = Word.new
  end

  def create
    @word = current_user.words.build(word_params)
    if @word.save
      flash.notice = "New word has been saved."
      redirect_to request.referer || word_path
    else
      flash[:alert] = @word.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def show
  end

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
    @word = current_user.words.where('next_review_date IS NULL OR next_review_date <= ?', Date.today).order('RANDOM()').first
  
    if @word.nil?
      flash[:notice] = 'Review completed!今日の振り返りは完了したよ!'
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
      @word.update(review_status: 'hard', next_review_date: Date.today) # 何度も表示
    end
    redirect_to random_words_path
  end

  private

  def word_params
    params.require(:word).permit(:english_word, :meaning, :example)
  end
end
