class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :words, dependent: :destroy
  has_many :pronunciation_scores, dependent: :destroy
  has_many :pronunciation_texts, through: :pronunciation_scores, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_videos, through: :likes, source: :video
  validates :username, presence: true, length: { minimum: 2 }
  validates :password, presence: true, on: :create

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.top_ranking_for_week(level, start_date, end_date, limit = 10)
    select('users.id, users.username,
               AVG(pronunciation_scores.accuracy_score) AS avg_accuracy_score,
               AVG(pronunciation_scores.pronunciation_score) AS avg_pronunciation_score,
               AVG(pronunciation_scores.fluency_score) AS avg_fluency_score,
               AVG(pronunciation_scores.completeness_score) AS avg_completeness_score,
               (AVG(pronunciation_scores.accuracy_score) + AVG(pronunciation_scores.pronunciation_score) +
                AVG(pronunciation_scores.fluency_score) + AVG(pronunciation_scores.completeness_score)) / 4 AS overall_average')
      .joins(pronunciation_scores: :pronunciation_text)
      .where(pronunciation_texts: { difficulty: level })
      .where(pronunciation_scores: { created_at: start_date..end_date })
      .group('users.id, users.username')
      .order('overall_average DESC')
      .limit(limit)
  end
end
