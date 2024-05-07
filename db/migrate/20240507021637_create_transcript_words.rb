class CreateTranscriptWords < ActiveRecord::Migration[7.1]
  def change
    create_table :transcript_words do |t|
      t.references :transcript, null: false, foreign_key: true
      t.references :word, null: false, foreign_key: true

      t.timestamps
    end
    add_index :transcript_words, [:transcript_id, :word_id], unique: true
  end
end
