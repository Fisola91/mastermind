class Turn
  def initialize(passcode:)
    @passcode = passcode
  end

  def guess(colors)
    result = {}
    colors.each_with_index do |color, idx|
      if passcode[idx] == color
        result[color] = :exact
      elsif passcode.include?(color)
        result[color] ||= :partial
      end
    end
    result.values.sort
  end

  private

  attr_reader :passcode
end
