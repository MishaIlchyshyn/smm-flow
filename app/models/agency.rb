class Agency < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :clients, dependent: :destroy
  has_many :projects, dependent: :destroy

  validates :name, :slug, :timezone, presence: true
  validates :name, :slug, uniqueness: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    return if name.blank?

    base_slug = name.parameterize
    self.slug = base_slug
    counter = 1

    while Agency.exists?(slug:)
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
end
