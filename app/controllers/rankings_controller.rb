class RankingsController < ApplicationController
  def index
    start_date = Date.current.beginning_of_week
    end_date = Date.current.end_of_week

    @normal_ranking = fetch_ranking('Normal', start_date, end_date)
    @hard_ranking = fetch_ranking('Hard', start_date, end_date)
    @user_name = current_user.username
  end

  private

  def fetch_ranking(level, start_date, end_date)
    ranked_users = User.top_ranking_for_week(level, start_date, end_date)
  
    ranked_users_with_rank = []
    ranked_users.each_with_index do |user, index|
      ranked_users_with_rank << { rank: index + 1, user: user, score: user.overall_average }
    end
  
    fill_ranking(ranked_users_with_rank)
  end

  def fill_ranking(ranking)
    (1..15).map do |rank|
      entry = ranking.find { |e| e[:rank] == rank }
      entry || { rank: rank, user: nil, score: nil }
    end
  end
end