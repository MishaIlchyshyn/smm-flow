class Client < ApplicationRecord
  belongs_to :agency

  enum :kind, {
    lead: 0,
    client: 1
  }

  scope :ordered, -> { order(created_at: :desc) }

  validates :name, :kind, presence: true
end
