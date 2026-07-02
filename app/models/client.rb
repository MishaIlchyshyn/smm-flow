class Client < ApplicationRecord
  belongs_to :agency

  has_many :projects, dependent: :destroy

  enum :source, {
    ad: 0,
    instagram: 1,
    referral: 2,
    organic: 3,
    other: 4
  }

  enum :kind, {
    lead: 0,
    customer: 1,
    terminated: 2
  }

  scope :ordered, -> { order(created_at: :desc) }

  validates :business_name, :owner_name, :email, :phone, presence: true

  before_save :set_converted_at

  private

  def set_converted_at
    return unless kind_changed?

    self.converted_at = customer? ? Time.current : nil
  end
end
