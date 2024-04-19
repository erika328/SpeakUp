class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.references :user, null: false, foreign_key: true
      t.string :english_word, null: false
      t.string :japanese_meaning, null: false

      t.timestamps
    end
    
    add_index :words, :english_word, unique: true
  end
end
