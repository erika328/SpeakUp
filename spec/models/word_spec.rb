require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do 
    let(:word) {build(:word, user: user)}

    describe 'english_word' do
      describe "presence" do
        before do
          word.english_word = nil
          word.valid?
        end
        it { expect(word.errors.messages[:english_word]).to include "can't be blank"}
      end

      describe 'length' do
        before do
          word.english_word = "a" * 21
          word.valid?
        end
        it { expect(word.errors.messages[:english_word]).to include "is too long (maximum is 20 characters)"}
      end

      describe 'uniqueness' do
        let!(:word_a) {create(:word, english_word: 'apple', part_of_speech: 'noun', user: user)} 
        before do
          word.english_word = 'apple'
          word.part_of_speech = 'noun'
          word.valid?
        end
        it { expect(word.errors.messages[:english_word]).to include "has already been taken"}
      end
    end

    describe 'meaning' do
      describe 'presence' do
        before do
          word.meaning = nil
          word.valid?
        end
        it { expect(word.errors.messages[:meaning]).to include "can't be blank"}
      end

      describe 'length' do
        before do
          word.meaning = "a" * 301
          word.valid?
        end
        it { expect(word.errors.messages[:meaning]).to include "is too long (maximum is 300 characters)"}
      end
    end

    describe 'part_of_speech' do
      describe 'presence' do
        before do
          word.part_of_speech = nil
          word.valid?
        end
        it { expect(word.errors.messages[:part_of_speech]).to include "can't be blank"}
      end
    end

    describe 'example' do
      describe 'accept nil' do
        before do
          word.example = nil
        end
        it { expect(word).to be_valid }
      end

      describe 'length' do
        before do
          word.example = "a" * 501
          word.valid?
        end
        it { expect(word.errors.messages[:example]).to include "is too long (maximum is 500 characters)"}
      end
    end
  end
end