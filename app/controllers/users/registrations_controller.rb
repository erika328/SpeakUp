# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  before_action :check_google_user, only: [:update]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if verify_recaptcha && @user.save
      sign_in(@user) # ユーザーをログインさせる
      flash[:success] = "User successfully created."
      redirect_to videos_path
    else
      flash.now[:alert] = "User registration failed."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    session[:previous_page] = request.referer
    super
  end

  def update
    @user = current_user

    # 許可するパラメータを制御する
    if @user.provider == 'google_oauth2'
      permitted_params = user_params.except(:email)
    else
      permitted_params = user_params
    end

    if @user.update(permitted_params)
      redirect_to session.delete(:previous_page) || root_path, notice: 'User was successfully updated.'
    else
      super
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  # end

  # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   words_path(resource)
  # end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private

    def check_google_user
      @user = current_user
      if @user.provider == 'google_oauth2' && user_params[:email].present?
        flash[:alert] = "Google認証ユーザーはメールアドレスを変更できません。"
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :receive_reminders, :time_zone)
    end
end
