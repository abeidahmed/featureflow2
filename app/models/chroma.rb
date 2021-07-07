class Chroma
  VALID_HEX_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i

  def initialize(hex)
    raise ArgumentError unless hex.match?(VALID_HEX_REGEX)

    @hex = hex.downcase
  end

  def normalize
    if triple_hex?
      six_char_hex = stripped_hex.split.cycle(2).to_a.join
      "##{six_char_hex}"
    else
      @hex
    end
  end

  private

  def stripped_hex
    @hex.slice(1..-1)
  end

  def triple_hex?
    stripped_hex.length == 3
  end
end
