class Word < ApplicationRecord
  validates :english_word, presence: true, length: { maximum: 20 }
  validates :japanese_meaning, presence: true, length: { maximum: 50 }

  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["english_word", "japanese_meaning"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
