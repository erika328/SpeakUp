class CreatePronunciationScores < ActiveRecord::Migration[7.1]
  def change
    create_table :pronunciation_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pronunciation_text, null: false, foreign_key: true
      t.decimal :accuracy_score, null: false, precision: 5, scale: 2 
      t.decimal :pronunciation_score, null: false, precision: 5, scale: 2 
      t.decimal :fluency_score, null: false, precision: 5, scale: 2 
      t.decimal :completeness_score, null: false, precision: 5, scale: 2 

      t.timestamps
    end
  end
end
