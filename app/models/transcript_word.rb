class TranscriptWord < ApplicationRecord
  belongs_to :transcript
  belongs_to :word
end
