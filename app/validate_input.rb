require_relative "constant_variable"

class UnknownColorError < StandardError; end
class NumberOfColorsError < StandardError; end

class ValidateInput
  include ChancesAndGuesses
  def self.call(colors)
    unless colors.all? { |guess| COLORS.include?(guess) }
      raise UnknownColorError
    end

    if colors.length != 4
      raise NumberOfColorsError
    end
  end
end
