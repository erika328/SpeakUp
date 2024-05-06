class Video < ApplicationRecord
  has_one :transcript

  def self.ransackable_attributes(auth_object = nil)
    ["difficulty"]
  end
end
