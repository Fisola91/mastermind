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

  def outer_circle_class(guess_number, cell_number)
    classes = %w(guess-cell)

    attempt = attempts[guess_number - 1]

    if attempt
      guessed_value = attempt.values[cell_number]
      classes << "bg-#{guessed_value.downcase}"
    end

    if guess_number == current_attempt && cell_number == 0
      classes << "current-cell"
    end

    classes.join(" ")
  end

  def inner_circle_class(guess_number)
    classes = %w(inner-guess-cell)
    attempt = attempts[guess_number - 1]
    if attempt.nil?
      classes << "bg-black"
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

  def game_outcome
    if !attempts.empty? && passcode == last_attempt
      return "Congratulations!"
    elsif attempts.size == guesses.size && passcode != last_attempt
      return "Sorry, you've lost! It was a bit difficult"
    end
  end

  def last_attempt
    attempts.last.values
  end

  def feedback_class(item)
    COLOR_CLASS_MAP.fetch(item)
  end

  def game_url
    game_attempts_path(game.id)
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
