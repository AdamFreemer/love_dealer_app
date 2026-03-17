module ApplicationHelper
  def render_field(label, value)
    content_tag(:div) do
      content_tag(:div, label, class: "text-xs uppercase tracking-widest text-muted mb-1") +
      content_tag(:div, value.presence || "—", class: "text-sm text-cream/80")
    end
  end
end
