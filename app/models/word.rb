class Word < ApplicationRecord
  validates :english_word, presence: true, length: { maximum: 20 }
  validates :japanese_meaning, presence: true, length: { maximum: 50 }

  belongs_to :user
end
