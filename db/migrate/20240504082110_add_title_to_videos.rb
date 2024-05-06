class AddTitleToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :title, :string, null: false
  end
end
