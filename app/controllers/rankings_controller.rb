class RankingsController < ApplicationController
  def index
    @normal_ranking = fetch_ranking('Normal')
    @hard_ranking = fetch_ranking('Hard')
    @user_name = current_user.username
  end

  private

  def fetch_ranking(level)
    ranked_users = User.top_ranking_for_level(level)

    ranked_users_with_rank = []
    previous_score = nil
    current_rank = 0

    ranked_users.each_with_index do |user, index|
      score = user.overall_average

      if score != previous_score
        current_rank = index + 1
      end

      ranked_users_with_rank << { rank: current_rank, user: user, score: score }
      previous_score = score
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
