class Agency < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :clients, dependent: :destroy

  validates :name, presence: true
end
