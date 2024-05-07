class Transcript < ApplicationRecord
  belongs_to :video
  has_many :transcript_words
  has_many :words, through: :transcript_words
end
