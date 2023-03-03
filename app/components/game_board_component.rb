require "json"
require "./app/turn"

class GameBoardComponent < ViewComponent::Base
  COLOR_CLASS_MAP = {
    partial: "bg-white",
    exact: "bg-green",
    nil => "bg-black",
  }

  def initialize(game:, attempts:)
    @game = game
    @attempts = attempts
  end

  def guesses
    (1..guess_attempts).to_a.reverse
  end

  def guess_class(guess_number, cell_number)
    attempt = attempts[guess_number - 1]
    guessed_value = attempt ? attempt.values[cell_number]  : nil
    bg_class = guessed_value ? "bg-#{guessed_value}" : "bg-black"
    "guess-cell ba b--black dib ml3 mt2 tc br4 rc #{bg_class}"
  end

  def feedback(guess_number)
    attempt = attempts[guess_number - 1]
    all_values = Array.new(code_length)
    return all_values if attempt.nil?

    turn = Turn.new(passcode: passcode)
    known_values = turn.guess(attempt.values)
    known_values.each_with_index do |known_value, idx|
      all_values[idx] = known_value
    end
    all_values
  end

  def feedback_class(item)
    COLOR_CLASS_MAP.fetch(item)
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

  attr_reader :attempts, :game

  private

  def passcode
    JSON.parse(game.passcode)
  end
end
