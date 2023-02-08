# require_relative "web_ui"
# require_relative "turn"
# # require "valid_color"
# class MiniMax
#   def initialize
#     colors = WebUI.new.colors.map(&:upcase)
#     @all_passcodes = colors.product(*[colors]*3)
#     @all_scores = Hash.new { |h, k| h[k] = {} }

#     @all_passcodes.product(@all_passcodes).each do |guess, passcode|
#       @all_scores[guess][passcode] = calculate_score(guess, passcode)
#       #calculate_score(guess, answer)
#     end

#     # p @all_passcodes = @all_passcodes.to_set
#   end

#   def play
#     @guesses = 0
#     @passcode = ["RED", "GREEN", "PURPLE", "RED"]
#     @possible_passcodes = @all_passcodes.dup
#     @possible_scores = @all_scores.dup
#     while @guesses < 10
#       @guess = make_guess
#       if @all_passcodes.include?(@guess)
#         @guesses += 1
#         @score = calculate_score(@guess, @passcode)
#         if @score == "BBBB"
#           p [@guesses, @guess, @passcode]
#           break
#         end
#       end
#     end
#   end


#   def make_guess
#     if @guesses > 0
#       puts "Score: #{@score}"
#     else
#       puts
#     end

#     puts "Guesses Remaining: #{10 - @guesses}"
#     print "Guesses: "
#     gets.chomp.split
#   end

#   # def make_guess
#   #   if @guesses > 0
#   #     @score = calculate_score(guess, passcode)
#   #     @possible_passcodes.keep_if do |passcode|
#   #       @all_scores[@guess][passcode] == @score
#   #     end
#   #     guesses = @possible_scores.map do |guess, scores_by_passcode|
#   #       scores_by_passcode = scores_by_passcode.select do |passcode, score|
#   #         @possible_passcodes.include?(passcode)
#   #       end
#   #       @possible_scores[guess] = scores_by_passcode

#   #       score_groups = scores_by_passcode.values.group_by(&:itself)
#   #       possibility_counts = score_groups.values.map(&:length)
#   #       worst_case_possibilities = possibility_counts.max
#   #       impossible_guess = @possible_passcodes.include?(guess) ? 0 : 1
#   #       [worst_case_possibilities, impossible_guess, guess]
#   #     end
#   #     guesses.min.last
#   #   else
#   #     "1122"
#   #   end
#   # end
# end

# a = MiniMax.new.play
# p a
