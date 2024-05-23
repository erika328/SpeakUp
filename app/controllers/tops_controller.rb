class TopsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @video = Video.find(1)
  end
end
