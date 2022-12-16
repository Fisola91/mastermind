require "rails_helper"
require "./app/computer_guesser"

VALID_COLORS = %w(RED ORANGE YELLOW GREEN BLUE PURPLE)

RSpec.describe ComputerGuesser do

  subject { described_class.new(previous_guesses)}
  let(:passcode) { ["GREEN", "RED", "PURPLE", "BLUE"] }

  context "when one match on first try" do
    let(:previous_guesses) do
      [
        AttemptWithFeedback.new(
          guess: ["GREEN", "ORANGE", "BLUE", "PURPLE"],
          feedback: [:exact]
        )
      ]
    end

    it "tries to confirm first is the exact, tries two new colors, moves second color to last" do
      next_guess = subject.guess(passcode)
      expect(next_guess).to eq(["GREEN", "RED", "YELLOW", "ORANGE"])
    end
  end

  context "when two match on second try" do
    let(:previous_guesses) do
      [
        AttemptWithFeedback.new(
          guess: ["GREEN", "ORANGE", "BLUE", "PURPLE"],
          feedback: [:exact]
        ),
        AttemptWithFeedback.new(
          guess: ["GREEN", "RED", "YELLOW", "ORANGE"],
          feedback: [:exact, :exact]
        )
      ]
    end

    it "tries to confirm three exact colors and one new colors" do
      next_guess = subject.guess(passcode)
      expect(next_guess).to eq(["GREEN", "RED", "PURPLE", "YELLOW"])
    end
  end

  context "when three match on third try" do
    let(:previous_guesses) do
      [
        AttemptWithFeedback.new(
          guess: ["GREEN", "ORANGE", "BLUE", "YELLOW"],
          feedback: [:exact]
        ),
        AttemptWithFeedback.new(
          guess: ["GREEN", "RED", "YELLOW", "ORANGE"],
          feedback: [:exact, :exact]
        ),
        AttemptWithFeedback.new(
          guess: ["GREEN", "RED", "PURPLE", "YELLOW"],
          feedback: [:exact, :exact, :exact]
        )
      ]
    end

    it "tries to confirm four exact colors" do
      next_guess = subject.guess(passcode)
      expect(next_guess).to eq(["GREEN", "RED", "PURPLE", "BLUE"])
    end
  end
end
