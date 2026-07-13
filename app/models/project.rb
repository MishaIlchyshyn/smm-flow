class Project < ApplicationRecord
  belongs_to :agency
  belongs_to :client

  has_one :brand_positioning, dependent: :destroy
  has_many :content_plan_items, dependent: :destroy

  enum :status, {
    active: 0,
    paused: 1,
    completed: 2,
    archived: 3
  }

  scope :ordered, -> { order(created_at: :desc) }

  validates :name, presence: true
  validate :client_belongs_to_agency

  private

  def client_belongs_to_agency
    errors.add(:client, "must belong to the same agency") if client && agency_id != client.agency_id
  end
end
