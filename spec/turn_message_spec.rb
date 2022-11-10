require "./app/turn_message"
require "./app/turn"

RSpec.describe TurnMessage do
  let(:passcode) { ["RED", "GREEN", "BLUE", "YELLOW"] }

  describe ".for" do
    describe "incorrect guess" do
      it "returns a message(incorrect guess) to the player" do
        turn = Turn.new(passcode: passcode)
        turn_message = turn.guess(["ORANGE", "ORANGE", "ORANGE", "ORANGE"])
        expect(described_class.for(turn_message)).to eq("Incorrect guess.")
      end
    end

    describe "unimplemented guess" do
      it "returns a message for result(guess colors) that aren't implemented." do
        turn = Turn.new(passcode: passcode)
        expect(described_class.for(turn)).to eq("Result message not implemented: #{turn.inspect}")
      end
    end

    describe "exact position" do
      context "all colors guessed at the exact position" do
        it "returns congratulatory message to the player" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "GREEN", "BLUE", "YELLOW"])
          expect(described_class.for(turn_message)).to eq("Congratulations!")
        end
      end

      context "one color guessed at the exact position" do
        it "returns a message for one correct guess color" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "ORANGE", "ORANGE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("One color guessed at the exact position.")
        end
      end

      context "two colors guessed at the exact position" do
        it "returns a message for two correct guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "GREEN", "ORANGE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("Two colors guessed at the exact position.")
        end
      end

      context "three colors guessed at the exact position" do
        it "returns a message for three correct guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "GREEN", "BLUE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("Three colors guessed at the exact position.")
        end
      end
    end

    describe "partial position" do
      context "all colors guessed at the wrong position" do
        it "returns a message for four partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["YELLOW", "BLUE", "GREEN", "RED"])
          expect(described_class.for(turn_message)).to eq("Four colors guessed at the wrong position.")
        end
      end

      context "three colors guessed at the wrong position" do
        it"returns a message for three partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["ORANGE", "BLUE", "GREEN", "RED"])
          expect(described_class.for(turn_message)).to eq("Three colors guessed at the wrong position.")
        end
      end

      context "two colors guessed at the wrong position" do
        it "returns a message for two partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["BLUE", "RED", "ORANGE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("Two colors guessed at the wrong position.")
        end
      end

      context "one color guessed at the wrong position" do
        it "returns a message for one partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["BLUE", "ORANGE", "ORANGE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("One color guessed at the wrong position.")
        end
      end
    end

    describe "exact and partial position" do
      context "one exact, one partial match" do
        it "returns a message for one :exact, one :partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "BLUE", "ORANGE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("Two colors guessed, one at the exact position and one at the wrong position.")
        end
      end

      context "two exact, one partial match" do
        it "returns a message for two :exact, one :partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "YELLOW", "BLUE", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("Three colors guessed, two at the exact position and one at the wrong position.")
        end
      end

      context "one exact, two partial match" do
        it "returns a message for one :exact, two :partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "BLUE", "YELLOW", "ORANGE"])
          expect(described_class.for(turn_message)).to eq("Three colors guessed, one at the exact position and two at the wrong position.")
        end
      end

      context "one exact, three partial match" do
        it "returns a message for one :exact, three :partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "BLUE", "YELLOW", "GREEN"])
          expect(described_class.for(turn_message)).to eq("Four colors guessed, one at the exact position and three at the wrong position.")
        end
      end

      context "three exact, one partial match" do
        it "returns a message for three :exact, one :partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "YELLOW", "BLUE", "YELLOW"])
          expect(described_class.for(turn_message)).to eq("Four colors guessed, three at the exact position and one at the wrong position.")
        end
      end

      context "two exact, two partial match" do
        it "returns a message for two :exact, two :partial guess colors" do
          turn = Turn.new(passcode: passcode)
          turn_message = turn.guess(["RED", "BLUE", "GREEN", "YELLOW"])
          expect(described_class.for(turn_message)).to eq("Four colors guessed, two at the exact position and two at the wrong position.")
        end
      end
    end
  end
end
