class Client < ApplicationRecord
  belongs_to :agency

  enum :kind, {
    lead: 0,
    customer: 1,
    terminated: 2
  }

  scope :ordered, -> { order(created_at: :desc) }

  validates :name, :kind, presence: true
end
