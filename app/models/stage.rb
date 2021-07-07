class Stage < ApplicationRecord
  DEFAULT_HEX = "#24292e".freeze

  acts_as_tenant :account
  acts_as_list scope: :account

  before_save :normalize_hex_value

  validates :name, presence: true, length: { maximum: 30 }
  validates :color, format: { with: Chroma::VALID_HEX_REGEX, message: "is not a valid hex code" }, allow_blank: true

  scope :order_by_position, -> { order(position: :asc) }

  private

  def normalize_hex_value
    self.color = color.present? ? Chroma.new(color).normalize : DEFAULT_HEX
  end
end
