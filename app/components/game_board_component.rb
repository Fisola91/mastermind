# frozen_string_literal: true
require "json"
require "./app/turn_message"

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

  def guess_rating(guess_number, cell_number)
    attempt = attempts[guess_number - 1]
    passcode = JSON.parse(game.passcode)
    guess = attempt ? attempt.values : nil
    return "guess_rating ba b--light-silver dib tc br4 w1 h1 bg-black" if guess.nil?
    feedback = feedback(passcode, guess, cell_number)
    bg_class = feedback ? "bg-#{feedback}" : "bg-black"
    "guess_rating ba b--light-silver dib tc br4 w1 h1 #{bg_class}"
  end

  def feedback(passcode, guess, cell_number)
    turn = Turn.new(passcode: passcode)
    result = turn.guess(guess)
    feedbacks = TurnMessage.for(result)
    feedback = feedbacks.delete_at(cell_number)
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

end
