class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_word
  before_action :set_pronunciation_text

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
  end

  private 
 def after_sign_in_path_for(resource)
    words_path # ログイン後に遷移するpathを設定
 end

 def after_sign_out_path_for(resource)
   new_user_session_path # ログアウト後に遷移するpathを設定
 end

 def set_word
  @word = Word.new
 end

 def set_pronunciation_text
  @random_pronunciation_text = PronunciationText.order("RANDOM()").first
 end
end
