class ContentPlanItem < ApplicationRecord
  belongs_to :project

  enum :platform, { instagram: 0, youtube: 1, tiktok: 2, linkedin: 3 }
  enum :content_type, { reel: 0, post: 1, story: 2, carousel: 3, video: 4 }
  enum :status, { idea: 0, in_progress: 1, ready: 2, posted: 3 }

  scope :ordered, -> { order(:scheduled_for) }

  validates :title, presence: true
  validates :scheduled_for, presence: true
end
