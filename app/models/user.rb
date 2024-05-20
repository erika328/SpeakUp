class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :words, dependent: :destroy
  has_many :pronunciation_scores, dependent: :destroy
  has_many :pronunciation_texts, through: :pronunciation_scores, dependent: :destroy
  validates :username, presence: true, length: { minimum: 2 }
  validates :password, presence: true, on: :create

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
