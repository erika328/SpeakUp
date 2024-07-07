class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.friendly.find(params[:id])
  end

  def profile
    @user = current_user
    @ranking = fetch_ranking.first(10)
  end

  private

    def fetch_ranking
      users_with_continuous_days = User.all.map do |user|
        { user:, continuous_days: user.continuous_days }
      end

      users_with_continuous_days.select { |entry| (entry[:continuous_days]).positive? }
                                .sort_by { |entry| -entry[:continuous_days] }
    end
end
