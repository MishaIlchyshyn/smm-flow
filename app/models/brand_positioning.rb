class BrandPositioning < ApplicationRecord
  belongs_to :project

  COMPLETE_POSITIONING_ATTRS = %i[brand_name target_audience tone_of_voice goals].freeze

  after_save :sync_positioning_complete

  private

  def sync_positioning_complete
    positioning_complete = COMPLETE_POSITIONING_ATTRS.all? { |attr| self[attr].present? }
    project.update(positioning_complete:) if project.positioning_complete != positioning_complete
  end
end
