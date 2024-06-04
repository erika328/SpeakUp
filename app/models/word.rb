class Word < ApplicationRecord
  validates :english_word, presence: true, length: { maximum: 30 }, uniqueness: { scope: :user_id }
  validates :japanese_meaning, presence: true, length: { maximum: 50 }
  validates :review_status, presence: true

  belongs_to :user
  has_many :transcript_words
  has_many :transcripts, through: :transcript_words

  scope :due_today, -> { where('next_review_date <= ?', Date.today) }
  before_create :set_default_values

  def self.ransackable_attributes(auth_object = nil)
    ["english_word", "japanese_meaning"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  private

  def set_default_values
    self.review_status ||= 'Hard'  # デフォルトでHardに設定
    self.next_review_date ||= Date.today  # デフォルトで今日の日付に設定
  end
end
