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

  private

  def word_params
    params.require(:word).permit(:english_word, :japanese_meaning)
  end
end
