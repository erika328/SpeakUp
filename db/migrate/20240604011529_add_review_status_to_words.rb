class AddReviewStatusToWords < ActiveRecord::Migration[7.1]
  def change
    add_column :words, :review_status, :string, default: 'hard'
    add_column :words, :next_review_date, :date
  end
end
