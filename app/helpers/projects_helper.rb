module ProjectsHelper
  STATUS_STYLES = {
    "active"    => "color: var(--violet-ink); background: var(--violet-soft)",
    "paused"    => "color: oklch(0.5 0.13 70); background: oklch(0.95 0.06 75)",
    "completed" => "color: var(--ok); background: oklch(0.94 0.05 155)",
    "archived"  => "color: var(--ink-soft); background: var(--violet-soft-2)"
  }.freeze

  STATUS_LABELS = {
    "active"    => "Active",
    "paused"    => "Paused",
    "completed" => "Completed",
    "archived"  => "Archived"
  }.freeze

  def project_status_style(status)
    STATUS_STYLES[status.to_s]
  end

  def project_status_label(status)
    STATUS_LABELS[status.to_s]
  end
end
