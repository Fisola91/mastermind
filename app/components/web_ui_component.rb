# frozen_string_literal: true

class WebUiComponent < ViewComponent::Base
  def guess_attempts
    10
  end

  def code_length
    4
  end

  def colors
    %w(
      red
      orange
      yellow
      green
      blue
      purple
    )
  end
  def number
    (1..10).to_a
  end
end
