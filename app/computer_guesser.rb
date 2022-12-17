AttemptWithFeedback = Struct.new(:guess, :feedback, keyword_init: true)
class ComputerGuesser
  def initialize(previous_guesses)
    @previous_guesses = previous_guesses
  end

  def guess
    updated_computer_guess = [" ", " ", " ", " "]
    case guess_count
    when 1
      case last_feedback
      when [:exact]
        return one_exact_color
      end
    else
      update_for(updated_computer_guess)
    end
    updated_last_guess(updated_computer_guess)
    feedbacks
  end

  private

  attr_reader :previous_guesses

  def feedbacks
    case last_feedback
    when [:exact, :exact]
      two_exact_colors
    when [:exact, :exact, :exact]
      three_exact_colors
    when [:exact, :exact, :exact, :exact]
      four_exact_colors
    when []
      four_untried_colors
    when [:exact, :exact, :partial, :partial]
      two_partial_two_exact_colors
    end
  end

  def one_exact_color
    [
      last_guess[0],
      untried_color[0],
      untried_color[1],
      last_guess[1]
    ]
  end

  def two_exact_colors
    [
      last_guess[0],
      last_guess[1],
      untried_color[1],
      last_guess[2]
    ]
  end

  def three_exact_colors
    [
      last_guess[0],
      last_guess[1],
      last_guess[2],
      untried_color[1]
    ]
  end

  def four_exact_colors
    [
      last_guess[0],
      last_guess[1],
      last_guess[2],
      last_guess[3]
    ]
  end

  def two_partial_two_exact_colors
    [
      last_guess[0],
      last_guess[2],
      untried_color[3],
      untried_color[1]
    ]
  end

  def four_untried_colors
    [
      untried_color[0],
      untried_color[0],
      untried_color[1],
      untried_color[1]
    ]
  end

  def update_for(updated_computer_guess)
    second_last_guess.each_with_index do |color, idx|
      if last_guess[idx] == color
        updated_computer_guess[idx] = color
      end
    end
    updated_computer_guess
  end

  def updated_last_guess(updated_computer_guess)
    updated_computer_guess.each_with_index do |value, idx|
      last_guess[idx] = value if value != " "
    end
  end

  def untried_color
    VALID_COLORS - last_guess
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
