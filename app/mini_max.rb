require_relative "web_ui"
require_relative "turn"
# require "valid_color"
class MiniMax
  attr_reader :passcode
  def initialize(passcode:, colors: WebUI.new.colors.map(&:upcase))
    @passcode = passcode
    @all_passcodes = colors.product(*[colors]*3)
    @all_scores = Hash.new { |h, k| h[k] = {} }

    @all_passcodes.product(@all_passcodes).each do |guess, passcode|
      @all_scores[guess][passcode] = Turn.new(passcode: passcode).guess(guess)
    end
  end

  def play
    @guesses = 0
    @possible_passcodes = @all_passcodes.dup
    @possible_scores = @all_scores.dup
    while @guesses < 10
      @guess = make_guess
      if @all_passcodes.include?(@guess)
        @guesses += 1
        @score = Turn.new(passcode: passcode).guess(@guess)
        if @score == [:exact, :exact, :exact, :exact]
          p @guesses, @guess, passcode
          break
        else
          p @guesses, @guess, passcode
        end
      end
    end
    @guess
  end

  def make_guess
    if @guesses > 0
      @possible_passcodes.keep_if do |passcode|
        @all_scores[@guess][passcode] == @score
      end
      guesses = @possible_scores.map do |guess, scores_by_passcode|
        filtered_passcodes = scores_by_passcode.keys & @possible_passcodes
        scores_by_passcode = scores_by_passcode.slice(*filtered_passcodes)

        @possible_scores[guess] = scores_by_passcode

        score_groups = scores_by_passcode.values.group_by(&:itself)
        possibility_counts = score_groups.values.map(&:length)
        worst_case_possibilities = possibility_counts.max
        impossible_guess = @possible_passcodes.include?(guess) ? 0 : 1
        [worst_case_possibilities, impossible_guess, guess]
      end
      guesses.min.last
    else
      ["BLUE", "BLUE", "GREEN", "GREEN"]
    end
  end
end
