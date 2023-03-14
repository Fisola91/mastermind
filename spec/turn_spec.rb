require "./app/turn"

RSpec.describe Turn do
  let(:passcode) { ["RED", "GREEN", "BLUE", "YELLOW"] }

  describe "#guess" do
    context "no elements guessed exactly" do
      it "returns an empty array" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["ORANGE", "ORANGE", "ORANGE", "ORANGE"])
        expect(feedback).to eq []
      end
    end

    context "one element guessed exactly" do
      it "returns one :exact value" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "ORANGE", "ORANGE", "ORANGE"])
        expect(feedback).to eq [:exact]
      end
    end

    context "two elements guessed at the exact position" do
      it "returns two :exact values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "GREEN", "ORANGE", "ORANGE"])
        expect(feedback).to eq [:exact, :exact]
      end
    end

    context "three elements guessed at the exact position" do
      it "returns three :exact values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "GREEN", "BLUE", "ORANGE"])
        expect(feedback).to eq [:exact, :exact, :exact]
      end
    end

    context "four colors guessed at the exact position" do
      it "returns four :exact values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "GREEN", "BLUE", "YELLOW"])
        expect(feedback).to eq [:exact, :exact, :exact, :exact]
      end
    end

    context "one colors guessed, wrong position" do
      it "returns one :partial value" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["ORANGE", "ORANGE", "ORANGE", "RED"])
        expect(feedback).to eq [:partial]
      end
    end

    context "two colors guessed, wrong positions" do
      it "returns two :partial values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["ORANGE", "ORANGE", "GREEN", "RED"])
        expect(feedback).to eq [:partial, :partial]
      end
    end

    context "three colors guessed, wrong positions" do
      it "returns three :partial values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["ORANGE", "BLUE", "GREEN", "RED"])
        expect(feedback).to eq [:partial, :partial, :partial]
      end
    end

    context "four colors guessed, wrong positions" do
      it "returns four :partial values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["YELLOW", "BLUE", "GREEN", "RED"])
        expect(feedback).to eq [:partial, :partial, :partial, :partial]
      end
    end

    context "one exact, one partial match" do
      it "returns one :exact, one :partial value" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "BLUE", "ORANGE", "ORANGE"])
        expect(feedback).to eq [:exact, :partial]
      end
    end

    context "two exact, two partial matches" do
      it "returns two :exact, two :partial values" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "GREEN", "YELLOW", "BLUE"])
        expect(feedback).to match_array [:exact, :partial, :partial, :exact]
      end
    end

    context "duplicate color guesses" do
      it "returns two :exact, ignoring two partials" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["GREEN", "GREEN", "BLUE", "BLUE"])
        expect(feedback).to match_array [:exact, :exact]
      end

      it "returns one :exact, ignoring three partials" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["GREEN", "GREEN", "GREEN", "GREEN"])
        expect(feedback).to match_array [:exact]
      end

      it "returns one :partial, ignoring two other partials" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["PURPLE", "RED", "RED", "RED"])
        expect(feedback).to match_array [:partial]
      end

      it "returns one :partial, one :exact, ignoring two different partials" do
        turn = Turn.new(passcode: passcode)
        feedback = turn.guess(["RED", "BLUE", "RED", "BLUE"])
        expect(feedback).to match_array [:exact, :partial]
      end
    end
  end
end
