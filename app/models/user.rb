class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :agency

  validates :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].compact_blank.join(" ")
  end

  def avatar
    [first_name, last_name].compact_blank.map { |n| n[0] }.join.upcase
  end
end
