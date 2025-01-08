require 'rails_helper'

RSpec.describe "Words", type: :system do
  let(:user) { create(:user) }
  let(:word) { create(:word, user: user) }

  before do
    driven_by(:rack_test)
    sign_in user
  end

  it "creates a new Word" do
    visit words_path
    all('label[for="my_modal"]').first.click

    fill_in "English word", with: "test"
    fill_in "Meaning", with: "a procedure intended to establish the quality, performance, or reliability of something"
    select "noun (名詞)", from: "Part of speech"
    fill_in "Example", with: "This is a test sentence."

    click_button "Save Word"

    expect(page).to have_content("test")
  end

  describe "editing a word" do
    it "updates the word successfully" do
      visit edit_word_path(word)
      expect(page).to have_current_path(edit_word_path(word))
      within("[data-form-type='edit']") do
        fill_in "English word", with: "Updated Word"
        click_button "Save Word"
      end

      expect(page).to have_content("Word has been updated.")
      expect(word.reload.english_word).to eq("Updated Word")
    end

    it "shows validation errors" do
      visit edit_word_path(word)
      within("[data-form-type='edit']") do
        fill_in "English word", with: ""
        click_button "Save Word"
      end
      expect(page).to have_content("can't be blank")
    end
  end
end
