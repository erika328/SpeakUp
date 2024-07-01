class PronunciationText < ApplicationRecord
  has_many :pronunciation_scores, dependent: :destroy
  has_many :users, through: :pronunciation_scores

  scope :for_user_and_difficulty, ->(user, difficulty) {
    joins(:pronunciation_scores)
      .where(pronunciation_scores: { user_id: user.id }, difficulty: difficulty)
      .distinct
  }
end
