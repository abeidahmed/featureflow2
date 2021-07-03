class AvatarComponent < ApplicationComponent
  COLORS = %w[
    #EF4444 #F97316 #F59E0B #EAB308 #84CC16
    #22C55E #10B981 #14B8A6 #06B6D4 #0EA5E9
    #3B82F6 #6366F1 #8B5CF6 #A855F7 #D946EF
    #EC4899 #F43F5E #25C5A3 #067F8C #910BFE
    #4A4A4A #EC4899 #10B981 #F59E0B #06B6D4
    #D946EF
  ].freeze

  def initialize(user:, size: 9, **options)
    @user = user
    @options = options

    @options[:tag] ||= :div
    @options[:classes] = class_names(
      options[:classes],
      "avatar",
      "avatar--#{size}",
      "rounded-full",
      "flex",
      "items-center",
      "justify-center",
    )
    @options[:style] = "background-color: #{avatar_bg_color}"
  end

  def call
    render ApplicationComponent.new(**@options) do
      @user.name.initials
    end
  end

  private

  def avatar_bg_color
    COLORS[@user.name.initials.first.to_s.downcase.ord - 97] || "#24292E"
  end
end
