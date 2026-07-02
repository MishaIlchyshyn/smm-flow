class Project < ApplicationRecord
  belongs_to :agency
  belongs_to :client

  enum :status, {
    active: 0,
    paused: 1,
    completed: 2,
    archived: 3
  }

  scope :ordered, -> { order(created_at: :desc) }

  validates :name, presence: true
end
