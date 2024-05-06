class CreateTranscripts < ActiveRecord::Migration[7.1]
  def change
    create_table :transcripts do |t|
      t.text :content
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
