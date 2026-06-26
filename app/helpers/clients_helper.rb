module ClientsHelper
  KIND_STYLES = {
    "lead"       => "color: var(--info); background: oklch(0.94 0.04 240)",
    "customer"   => "color: var(--ok); background: oklch(0.94 0.05 155)",
    "terminated" => "color: var(--bad); background: oklch(0.96 0.04 27)"
  }.freeze

  def kind_tag_style(kind)
    KIND_STYLES[kind.to_s]
  end
end
