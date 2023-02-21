# frozen_string_literal: true
require "json"

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
    result = ""
    attempt = attempts[guess_number - 1]
    passcode = JSON.parse(game.passcode)
    guess = attempt ? attempt.values[cell_number]  : nil
    passcode.each do |code|
      if guess == passcode[cell_number]
        result = "green"
      elsif passcode.include?(guess)
        result = "white"
      else
        result = "black"
      end
    end
    "guess_rating ba b--light-silver dib tc br4 bg-#{result}"
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
# .guess-rating.ba.b--light-silver.dib.tc.br4.bg-black data-number=cell_number
