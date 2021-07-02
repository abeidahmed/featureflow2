module SvgHelper
  def render_svg(icon_name, **options)
    icon = Remix.new(icon_name, **options)
    content_tag(:svg, icon.svg_path.html_safe, icon.options) # rubocop:disable Rails/OutputSafety
  end
end
