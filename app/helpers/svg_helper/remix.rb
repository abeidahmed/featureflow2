# rubocop:disable Rails/HelperInstanceVariable
module SvgHelper
  class Remix
    attr_reader :options

    VARIANT_TYPES = %w[stroke solid].freeze
    ICON_PATH = Rails.root.join("app/assets/images/svg")

    def initialize(icon, size: 20, variant: "stroke", **options)
      @icon = icon.to_s
      @variant = variant.to_s
      raise ArgumentError, "Variant must be one of #{VARIANT_TYPES.join(', ')}" unless VARIANT_TYPES.include?(@variant)

      @options = options
      @options.merge!(a11y)
      @options.merge!({
        width: size,
        height: size,
        viewBox: "0 0 24 24",
        class: classes
      })
    end

    def svg_path
      file_path = if stroke_variant?
                    "#{ICON_PATH}/#{@icon}.svg"
                  else
                    "#{ICON_PATH}/#{@icon}-solid.svg"
                  end
      raise ArgumentError, "Couldn't find icon for #{@icon}" unless File.exist?(file_path)

      file = File.read(file_path)
      doc = Nokogiri::HTML::DocumentFragment.parse(file)
      doc.at_css("svg").inner_html
    end

    private

    def classes
      css_classes = "remix remix-#{@icon} #{options[:class]} "
      css_classes << "remix-#{@icon}-solid" if solid_variant?
      css_classes.strip
    end

    def a11y
      accessible = {}

      if options[:"aria-label"].nil? && options["aria-label"].nil? && options.dig(:aria, :label).nil?
        accessible[:"aria-hidden"] = "true"
      else
        accessible[:role] = "img"
      end

      accessible
    end

    def stroke_variant?
      @variant == "stroke"
    end

    def solid_variant?
      @variant == "solid"
    end
  end
end
# rubocop:enable Rails/HelperInstanceVariable
