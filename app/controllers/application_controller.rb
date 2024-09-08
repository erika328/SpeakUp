class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_time_zone

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
    end

  private

    def after_sign_in_path_for(resource)
      videos_path # ログイン後に遷移するpathを設定
    end

    def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
    end

    def set_time_zone
      Time.zone = current_user.time_zone if current_user
    end
end
