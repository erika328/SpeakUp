class Word < ApplicationRecord
  validates :english_word, presence: true, length: { maximum: 20 }, uniqueness: { scope: [:user_id, :part_of_speech], case_sensitive: false }
  validates :meaning, presence: true, length: { maximum: 300 }
  validates :part_of_speech, presence: true
  validates :example, length: { maximum: 500 }
  validates :review_status, presence: true

  belongs_to :user
  has_many :transcript_words, dependent: :destroy
  has_many :transcripts, through: :transcript_words

  scope :due_today, -> { where('next_review_date <= ?', Time.zone.today) }
  before_create :set_default_values

  def self.ransackable_attributes(auth_object = nil)
    ["english_word", "meaning", "part_of_speech"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  private

    def set_default_values
      self.review_status ||= 'Hard'
      self.next_review_date ||= Time.zone.today
    end
end
