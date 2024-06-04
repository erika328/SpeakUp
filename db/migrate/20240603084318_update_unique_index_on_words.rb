class UpdateUniqueIndexOnWords < ActiveRecord::Migration[7.1]
  def change
    remove_index :words, :english_word
    add_index :words, [:user_id, :english_word], unique: true
  end
end
