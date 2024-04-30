class WordsController < ApplicationController
  def index
    @words = current_user.words
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
      flash.now.notice = "Word has been updated."
    else
      # バリデーションエラー時にはedit.html.erbをrenderする
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def word_params
    params.require(:word).permit(:english_word, :japanese_meaning)
  end
end
