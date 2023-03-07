class ValidColors
  VALUES = %w(
    RED
    ORANGE
    YELLOW
    GREEN
    BLUE
    PURPLE
  )

  def self.four_random_colors
    VALUES.shuffle.take(4)
  end
end
