class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :agencies, through: :memberships

  validates :full_name, presence: true

  attr_accessor :agency_name, :agency_timezone

  def avatar
    avatar_url.presence || avatar_abbr
  end

  def role_for(agency)
    memberships.find_by(agency:).role
  end

  private

  def avatar_abbr
    full_name.split.map { |w| w[0] }.first(2).join.upcase
  end
end
