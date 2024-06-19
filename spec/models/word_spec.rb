require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      english_word: "test",
      meaning: "a procedure intended to establish the quality, performance, or reliability of something",
      part_of_speech: "noun",
      example: "This is a test sentence.",
      review_status: "Hard",
      user: user
    }
  end

  it "is valid with valid attributes" do
    word = Word.new(valid_attributes)
    expect(word).to be_valid
  end

  it "is not valid without an english_word" do
    word = Word.new(valid_attributes.merge(english_word: nil))
    expect(word).to_not be_valid
  end

  it "is not valid without a meaning" do
    word = Word.new(valid_attributes.merge(meaning: nil))
    expect(word).to_not be_valid
  end

  it "is not valid without a part_of_speech" do
    word = Word.new(valid_attributes.merge(part_of_speech: nil))
    expect(word).to_not be_valid
  end

  it "is not valid without a review_status" do
    word = Word.new(valid_attributes.merge(review_status: nil))
    expect(word).to_not be_valid
  end

  it "is not valid with an english_word longer than 20 characters" do
    word = Word.new(valid_attributes.merge(english_word: "a" * 21))
    expect(word).to_not be_valid
  end

  it "is not valid with a meaning longer than 300 characters" do
    word = Word.new(valid_attributes.merge(meaning: "a" * 301))
    expect(word).to_not be_valid
  end

  it "is not valid with an example longer than 500 characters" do
    word = Word.new(valid_attributes.merge(example: "a" * 501))
    expect(word).to_not be_valid
  end
end