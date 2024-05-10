class PronunciationText < ApplicationRecord
  has_many :pronunciation_scores
  has_many :users, through: :pronunciation_scores
end
