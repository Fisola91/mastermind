class Computer
  COLORS = ["RED", "GREEN", "YELLOW", "BLUE", "PURPLE", "ORANGE"]

  def initialize(game:, player:)
    @game = game
    @player = player

    @board = nil
    @possible_combos = COLORS.repeated_permutation(4).to_a
    @guess = nil
  end

  def guess(remaining_guesses)
    case remaining_guesses
    when 12 then @guess = %w(RED RED GREEN GREEN)
    when 11 then @guess = %w(BLUE BLUE YELLOW YELLOW)
    when 10 then @guess = %w(ORANGE ORANGE PURPLE PURPLE)
    else
      @guess = @possible_combos.sample(1)
    end
    @guess
  end

  def filter_combos(right_color, right_spot)
    last_guess_rc = right_color
    last_guess_rs = right_spot
    temp = @guess.clone

    @possible_combos.each do |permutation|
      turn = Turn.new(passcode: temp)
      result = turn.guess(permutation)
      wtf_rc = result.count { |i| i == :partial}
      wtf_rs = result.count { |i| i == :exact }

      if last_guess_rc + last_guess_rs == 0
        temp.each do |color|
          @possible_combos.delete_if { |permutation| permutation.include?(color) }
        end
      end

      if ((last_guess_rc != wtf_rc) && (last_guess_rs != wtf_rs))
        @possible_combos.delete(permutation)
      end
    end
    puts "#{@possible_combos.size} possible combinations left"
  end

  private

  attr_reader :possible_combos
end
