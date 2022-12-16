AttemptWithFeedback = Struct.new(:guess, :feedback, keyword_init: true)
class ComputerGuesser
  def initialize(previous_guesses)
    @previous_guesses = previous_guesses
  end

  def guess(passcode)
    updated_computer_guess = [" ", " ", " ", " "]
    if guess_count == 1
      if last_feedback == [:exact]
        untried_color = VALID_COLORS - last_guess
        return [
          last_guess[0],
          untried_color[0],
          untried_color[1],
          last_guess[1]
        ]
      end
    else
      last_guess.each_with_index do |color, idx|
        if passcode[idx] == color
          updated_computer_guess[idx] = color
        end
      end
    end
    updated_computer_guess.each_with_index do |value, idx|
      last_guess[idx] = value if value != " "
    end

    case last_feedback
    when [:exact, :exact]
      untried_color = VALID_COLORS - last_guess
      return[
        last_guess[0],
        last_guess[1],
        untried_color[1],
        last_guess[2]
      ]
    when [:exact, :exact, :exact]
      untried_color = VALID_COLORS - last_guess
      return[
        last_guess[0],
        last_guess[1],
        last_guess[2],
        untried_color[1]
      ]
    end

  end

  private

  attr_reader :previous_guesses

  def untried
    color_difference = VALID_COLORS - last_guess
    [
      last_guess[0],
      color_difference[0],
      color_difference[1],
      last_guess[1]
    ]
  end

  def guess_count
    previous_guesses.size
  end

  def last_guess
    previous_guesses.last.guess
  end

  def second_last_guess
    previous_guesses[-2].guess
  end

  def last_feedback
    previous_guesses.last.feedback
  end
end
