require "rails_helper"
require "./app/computer_guesser"

VALID_COLORS = %w(RED ORANGE YELLOW GREEN BLUE PURPLE)

RSpec.describe ComputerGuesser do

  subject { described_class.new(previous_guesses)}

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
      next_guess = subject.guess
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

    it "tries to confirm two exact colors, one new color and move third color to last" do
      next_guess = subject.guess
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


    it "tries to confirm three exact colors and one new color" do
      next_guess = subject.guess
      expect(next_guess).to eq(["GREEN", "RED", "PURPLE", "BLUE"])
    end
  end

  context "when four exact match on third try" do
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
          guess: ["GREEN", "RED", "PURPLE", "ORANGE"],
          feedback: [:exact, :exact, :exact, :exact]
        )
      ]
    end

    it "tries to confirm four exact colors" do
      next_guess = subject.guess
      expect(next_guess).to eq(["GREEN", "RED", "PURPLE", "ORANGE"])
    end
  end

  context "when no match on first try" do
    let(:previous_guesses) do
      [
        AttemptWithFeedback.new(
          guess: ["BLUE", "BLUE", "ORANGE", "ORANGE"],
          feedback: []
        )
      ]
    end

    it "tries to confirm no match with the previous color" do
      next_guess = subject.guess
      expect(next_guess).to eq(["RED", "RED", "YELLOW", "YELLOW"])
    end
  end

  context "when two exact and two partial match on second try" do
    let(:previous_guesses) do
      [
        AttemptWithFeedback.new(
          guess: ["BLUE", "BLUE", "ORANGE", "ORANGE"],
          feedback: []
        ),
        AttemptWithFeedback.new(
          guess: ["RED", "RED", "YELLOW", "YELLOW"],
          feedback: [:exact, :exact, :partial, :partial]
        )
      ]
    end

    it "tries to confirm two exact and partial colors" do
      next_guess = subject.guess
      expect(next_guess).to eq(["RED", "YELLOW", "PURPLE", "GREEN"])
    end
  end
end
