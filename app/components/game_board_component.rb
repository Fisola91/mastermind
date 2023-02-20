# frozen_string_literal: true

class GameBoardComponent < ViewComponent::Base
  def initialize(game:, attempts:)
    @game = game
    @attempts = attempts
  end

  def guesses
    (1..guess_attempts).to_a.reverse
  end

  def inner_guess_class(guess_number, cell_number)
    attempt = attempts[guess_number - 1]
    guessed_value = attempt ? attempt.values[cell_number]  : nil
    bg_class = guessed_value ? "bg-#{guessed_value}" : "bg-black"
    "inner-guess-cell ba b--black dib rc tc #{bg_class}"
  end

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

  attr_reader :attempts
end
