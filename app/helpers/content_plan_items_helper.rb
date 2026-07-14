module ContentPlanItemsHelper
  PLATFORM_LABELS = {
    "instagram" => "Instagram",
    "youtube" => "YouTube",
    "tiktok" => "TikTok",
    "linkedin" => "LinkedIn"
  }.freeze

  CONTENT_TYPE_LABELS = {
    "reel" => "Reel",
    "post" => "Post",
    "story" => "Story",
    "carousel" => "Carousel",
    "video" => "Video"
  }.freeze

  STATUS_LABELS = {
    "idea" => "Idea",
    "in_progress" => "In Progress",
    "ready" => "Ready",
    "posted" => "Posted"
  }.freeze

  STATUS_STYLES = {
    "idea" => "color: var(--ink-soft); background: var(--violet-soft-2)",
    "in_progress" => "color: oklch(0.5 0.13 70); background: oklch(0.95 0.06 75)",
    "ready" => "color: var(--violet-ink); background: var(--violet-soft)",
    "posted" => "color: var(--ok); background: oklch(0.94 0.05 155)"
  }.freeze

  def content_plan_item_platform_label(platform)
    PLATFORM_LABELS[platform.to_s]
  end

  def content_plan_item_content_type_label(content_type)
    CONTENT_TYPE_LABELS[content_type.to_s]
  end

  def content_plan_item_status_label(status)
    STATUS_LABELS[status.to_s]
  end

  def content_plan_item_status_style(status)
    STATUS_STYLES[status.to_s]
  end
end
