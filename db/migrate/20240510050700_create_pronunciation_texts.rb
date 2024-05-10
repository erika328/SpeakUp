class CreatePronunciationTexts < ActiveRecord::Migration[7.1]
  def change
    create_table :pronunciation_texts do |t|
      t.text :english_text, null: false
      t.text :japanese_text, null: false
      t.string :difficulty, null: false

      t.timestamps
    end
    add_index :pronunciation_texts, :difficulty
  end
end
