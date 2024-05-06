class AddDifficultyToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :difficulty, :string, null: false
    add_index :videos, :difficulty
  end
end
