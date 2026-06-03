class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :agencies, through: :memberships

  validates :full_name, presence: true

  attr_accessor :agency_name, :agency_timezone
end
