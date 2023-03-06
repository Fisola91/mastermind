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

  def current_attempt_class(guess_number)
    "current-attempt" if guess_number == current_attempt
  end

  def guesses
    (1..guess_attempts).to_a.reverse
  end

  def guess_class(guess_number, cell_number)
    classes = %w(guess-cell ba b--black dib ml3 mt2 tc br4 rc)

    attempt = attempts[guess_number - 1]
    guessed_value = attempt ? attempt.values[cell_number]  : nil
    bg_class = guessed_value ? "bg-#{guessed_value}" : "bg-black"
    classes << bg_class

    if guess_number == current_attempt && cell_number == 0
      classes << "current-cell"
    end

    classes.join(" ")
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

  def current_attempt
    attempts.size + 1
  end

  def passcode
    JSON.parse(game.passcode)
  end
end
