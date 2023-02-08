# frozen_string_literal: true
require "./app/web_ui"
require "./app/constant_variable"
require "./app/turn"
require "./app/turn_message"
require "json"
require "./app/controllers/games_controller"

class WebSubmitComponent < ViewComponent::Base
  include ChancesAndGuesses
  def initialize(game:)
    @game = game
  end

  attr_reader :game

  def attempts_left?
    current_attempt <= chances && !won?
  end

  def won?
    last_guess == passcode
  end

  def no_attempts?
    game.attempts.none?
  end

  def last_guess
    if no_attempts?
      []
    else
      game.attempts.last.values
    end
  end

  def passcode
    JSON.parse(game.passcode)
  end

  def chances
    CHANCES
  end

  def colors
    WebUI.new.colors
  end

  def message
    if no_attempts?
      nil
    elsif ran_out_of_attempts?
      "You lost, ran out of turns."
    else
      # turn = Turn.new(passcode: passcode)
      # result = turn.guess(last_guess)
      result = calculate_score(last_guess, passcode)
      TurnMessage.for(result)
    end
  end

  def previous_attempts
    game.attempts
  end

  def current_attempt
    previous_attempts.count + 1
  end

  def ran_out_of_attempts?
    current_attempt > CHANCES
  end

  def computer_guesses
    computer_tries = []
    computer_tries << ValidColor.passcode
    computer_tries.last
  end
end
