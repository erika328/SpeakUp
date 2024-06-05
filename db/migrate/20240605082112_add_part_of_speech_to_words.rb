class AddPartOfSpeechToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :part_of_speech, :string

    # 既存のインデックスを削除して新しいインデックスを作成
    remove_index :words, name: "index_words_on_user_id_and_english_word"
    add_index :words, [:user_id, :english_word, :part_of_speech], unique: true, name: "index_words_on_user_id_and_english_word_and_part_of_speech"
  end
end
