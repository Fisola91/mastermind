require_relative "../app/guesser"

VALID_COLORS = %w(RED ORANGE YELLOW GREEN BLUE PURPLE)

RSpec.describe Guesser do
  subject { described_class.new(previous_guesses) }

  context "given 1 exact match on first try" do
    let(:previous_guesses) do
      [
        AttemptWithFeedback.new(
          guess: %w(RED ORANGE YELLOW GREEN),
          feedback: [:exact]
        )
      ]
    end

    it "tries to confirm first is the exact, tries two new colors, moves second color to last" do
      next_guess = subject.guess
      expect(next_guess).to eq %w(RED BLUE PURPLE ORANGE)
    end
  end
end
