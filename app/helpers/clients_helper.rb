module ClientsHelper
  CLIENT_KINDS = %w[client lead].freeze

  def kind_label(kind)
    kind.to_s.humanize
  end

  def kind_badge(client)
    tag.span(kind_label(client.kind), class: "kind-tag kind-tag--#{client.kind}")
  end

  def kind_options
    CLIENT_KINDS.map { |kind| [kind_label(kind), kind] }
  end

  def website_label(url)
    url.to_s.strip.sub(%r{\Ahttps?://}i, "").sub(/\Awww\./i, "").chomp("/")
  end

  def website_href(url)
    url = url.to_s.strip
    url.match?(%r{\A[a-z][a-z0-9+.-]*://}i) ? url : "https://#{url}"
  end
end
