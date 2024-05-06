class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :video_id

      t.timestamps
    end
    add_index :videos, :video_id, unique: true
  end
end
