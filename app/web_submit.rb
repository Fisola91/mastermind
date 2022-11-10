require_relative "web_ui"
require_relative "constant_variable"

class WebSubmit
  # CHANCES = 4
  # GUESSED_CORRECTLY = [:exact, :exact, :exact, :exact]
  # NIL_GUESSES = [nil, nil, nil, nil]
  include ChancesAndGuesses

  def initialize(params)
    @params = params
  end

  def view
    not_lost = true
    next_attempt = current_attempt + 1
    won = false

    if any_attempts_left? && not_nil_guesses?
      begin
        ValidateInput.call(guess_colors)
      rescue UnknownColorError
        next_attempt -= 1
        error_message = "Invalid input, try again!"
      end

      if error_message.nil?
        turn = Turn.new(passcode: passcode)
        result = turn.guess(guess_colors)
        if result == GUESSED_CORRECTLY
          won = true
          message = TurnMessage.for(result)
        else
          if ran_out_of_attempts?
            not_lost = false
            message = "You lost, ran out of turns."
          else
            message = TurnMessage.for(result)
          end
        end
      end
    end

    OpenStruct.new(
      chances: CHANCES,
      not_lost: not_lost,
      current_attempt: current_attempt,
      next_attempt: next_attempt,
      error_message: error_message,
      message: message,
      colors: WebUI.new.colors,
      won: won,
      params: params,
    )
  end

  private

  attr_reader :params

  def any_attempts_left?
    current_attempt <= CHANCES
  end

  def not_nil_guesses?
    guess_colors != NIL_GUESSES
  end

  def current_attempt
    params[:current_attempt].to_i
  end

  def previous_attempt
    (current_attempt - 1).to_s
  end

  def ran_out_of_attempts?
    current_attempt == CHANCES
  end

  def passcode
    [
      params[:code1],
      params[:code2],
      params[:code3],
      params[:code4]
    ]
  end

  def guess_colors
    [
      params.dig("attempts", previous_attempt, "guess1"),
      params.dig("attempts", previous_attempt, "guess2"),
      params.dig("attempts", previous_attempt, "guess3"),
      params.dig("attempts", previous_attempt, "guess4")
    ]
  end
end
