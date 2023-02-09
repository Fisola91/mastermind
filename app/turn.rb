class Turn
  def initialize(passcode:)
    @passcode = passcode
  end

  def guess(colors)
    result = []
    colors.each_with_index do |color, idx|
      if passcode[idx] == color
        result << :exact
      elsif passcode.include?(color)
        result << :partial
      end
    end
    result.sort
  end

  private

  attr_reader :passcode
end
# class Turn
# # end
# def calculate_score(guess, passcode)
#   result = []
#   wrong_guess_pegs, wrong_passcode_pegs = [], []
#   peg_pairs = guess.zip(passcode)

#   peg_pairs.each do |guess_peg, passcode_peg|
#     if guess_peg == passcode_peg
#       result << :exact
#     else
#       wrong_guess_pegs << guess_peg
#       wrong_passcode_pegs << passcode_peg
#     end
#   end
#   wrong_guess_pegs.each do |peg|
#     if wrong_passcode_pegs.include?(peg)
#       wrong_passcode_pegs.delete(peg)
#       result << :partial
#     end
#   end
#   result.sort
# end
