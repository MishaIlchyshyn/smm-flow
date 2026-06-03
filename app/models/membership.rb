class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :agency

  enum :role, {
    owner: 0
  }

  enum :status, {
    active: 0
  }

  validates :user_id, uniqueness: { scope: :agency_id }
end
