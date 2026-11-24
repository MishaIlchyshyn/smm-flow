class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :agency

  validates :full_name, presence: true

  def avatar
    avatar_url.presence || avatar_abbr
  end

  private

  def avatar_abbr
    full_name.split.map { |w| w[0] }.first(2).join.upcase
  end
end
