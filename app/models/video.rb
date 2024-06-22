class Video < ApplicationRecord
  has_one :transcript
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  scope :liked_by_user, -> (user) { joins(:likes).where(likes: { user_id: user.id }) }

  def self.ransackable_attributes(auth_object = nil)
    ["difficulty", "liked_by_user"]
  end
end
