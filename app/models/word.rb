class Word < ApplicationRecord
  validates :english_word, presence: true, length: { maximum: 30 }
  validates :japanese_meaning, presence: true, length: { maximum: 50 }

  belongs_to :user
  has_many :transcript_words
  has_many :transcripts, through: :transcript_words

  def self.ransackable_attributes(auth_object = nil)
    ["english_word", "japanese_meaning"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
