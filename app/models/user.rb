class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:github]
  has_many :commits, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    where(github_username: auth.info.nickname).first_or_create do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
