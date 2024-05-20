# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
# callback for google
def google_oauth2
  callback_for(:google)
end

def callback_for(provider)
  @user = User.from_omniauth(request.env["omniauth.auth"])
  sign_in_and_redirect @user, event: :authentication
  set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
end

def failure
  redirect_to root_path
end
end
