class PronunciationScore < ApplicationRecord
  belongs_to :user
  belongs_to :pronunciation_text
end
