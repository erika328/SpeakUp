class Transcript < ApplicationRecord
  belongs_to :video
  has_many :transcript_words, dependent: :destroy
  has_many :words, through: :transcript_words
end
