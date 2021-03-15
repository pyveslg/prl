class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :commits, dependent: :destroy

  def full_name
    "#{first_name} #{short_last_name}".strip
  end

  private

  def short_last_name
    return if last_name.blank?

    "#{last_name[0]}."
  end
end
