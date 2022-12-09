AttemptWithFeedback = Struct.new(:guess, :feedback, keyword_init: true)

class Guesser
  def initialize(previous_guesses)
    @previous_guesses = previous_guesses
  end

  def guess
    case guess_count
    when 1
      case last_feedback
      when [:exact]
        untried_colors = VALID_COLORS - last_guess
        [
          last_guess[0],
          untried_colors[0],
          untried_colors[1],
          last_guess[1]
        ]
      else
        raise NotImplementedError
      end
    else
      raise NotImplementedError
    end
  end

  private

  attr_reader :previous_guesses

  def guess_count
    previous_guesses.size
  end

  def last_guess
    previous_guesses.last.guess
  end

  def last_feedback
    previous_guesses.last.feedback
  end
end
