class Turn
  def initialize(passcode:)
    @passcode = passcode
  end

  def guess(colors)
    result = []
    colors.each_with_index do |color, idx|
      if passcode[idx] == color
        result << :exact
      elsif passcode.include?(color)
        result << :partial
      end
    end
    result.sort
  end

  private

  attr_reader :passcode
end
