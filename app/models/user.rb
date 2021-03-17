class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :omniauthable, omniauth_providers: [:github]
  has_many :commits, dependent: :destroy

  def full_name
    "#{first_name} #{short_last_name}".strip
  end

  private

  def short_last_name
    return if last_name.blank?

    "#{last_name[0]}."
  end

  def self.from_omniauth(auth)
    user = where(github_username: auth.info.nickname).first
    return unless user

    user.update(
      email: auth.info.email,
      uid: auth.uid,
      provider: auth.provider,
      password: Devise.friendly_token[0, 20]
    )
    user
  end
end
