require "web_submit"


RSpec.describe WebSubmit do
  let(:params) do
    {
      current_attempt: current_attempt,
      code1: "RED",
      code2: "GREEN",
      code3: "BLUE",
      code4: "YELLOW",
      "attempts" => {
        (current_attempt - 1).to_s => {
          "guess1" => guess1,
          "guess2" => guess2,
          "guess3" => guess3,
          "guess4" => guess4,
        }
      }
    }
  end

  describe "#view" do
    context "first attempt, 4/4 match" do
      let(:current_attempt) { 2 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "YELLOW" }

      it "returns correct view values" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 3
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Congratulations!"
      end
    end
  end

  describe "cases: exact position(s)" do
    context "first attempt, 1/4 match" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { "PURPLE" }
      let(:guess3) { "ORANGE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for one accurate color guess" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq nil
        expect(view.message).to eq "One color guessed at the exact position."
      end
    end

    context "second attempt, 2/4 match" do
      let(:current_attempt) { 2 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "PURPLE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for two accurate color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 3
        expect(view.error_message).to eq nil
        expect(view.message).to eq  "Two colors guessed at the exact position."
      end
    end

    context "third attempt, 3/4 match" do
      let(:current_attempt) { 3 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for three accurate color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 3
        expect(view.next_attempt).to eq 4
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Three colors guessed at the exact position."
      end
    end

    context "fourth attempt, 4/4 match" do
      let(:current_attempt) { 4 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "YELLOW" }

      it "congratulates the player" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 4
        expect(view.next_attempt).to eq 5
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Congratulations!"
      end
    end
  end

  describe "cases: partial position(s)" do
    context "first attempt, 1/4 wrong position" do
      let(:current_attempt) { 1 }
      let(:guess1) { "GREEN" }
      let(:guess2) { "ORANGE" }
      let(:guess3) { "PURPLE" }
      let(:guess4) { "PURPLE" }

      it "returns a message for one wrong color guess" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq nil
        expect(view.message).to eq "One color guessed at the wrong position."
      end
    end

    context "second attempt, 2/4 wrong position" do
      let(:current_attempt) { 2 }
      let(:guess1) { "GREEN" }
      let(:guess2) { "YELLOW" }
      let(:guess3) { "PURPLE" }
      let(:guess4) { "PURPLE" }

      it "returns a message for two wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 3
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Two colors guessed at the wrong position."
      end
    end

    context "third attempt, 3/4 wrong position" do
      let(:current_attempt) { 3 }
      let(:guess1) { "GREEN" }
      let(:guess2) { "YELLOW" }
      let(:guess3) { "RED" }
      let(:guess4) { "PURPLE" }

      it "returns a message for three wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 3
        expect(view.next_attempt).to eq 4
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Three colors guessed at the wrong position."
      end
    end

    context "fourth attempt, 4/4 wrong position" do
      let(:current_attempt) { 4 }
      let(:guess1) { "GREEN" }
      let(:guess2) { "YELLOW" }
      let(:guess3) { "RED" }
      let(:guess4) { "BLUE" }

      it "returns a message for three wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq false
        expect(view.current_attempt).to eq 4
        expect(view.next_attempt).to eq 5
        expect(view.error_message).to eq nil
        expect(view.message).to eq "You lost, ran out of turns."
      end
    end
  end

  describe "cases: exact and partial positions" do
    context "first attempt, 1/4 match and 1/4 wrong" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { "YELLOW" }
      let(:guess3) { "PURPLE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for one accurate and one wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Two colors guessed, one at the exact position and one at the wrong position."
      end
    end

    context "second attempt, 2/4 match and 1/4 wrong" do
      let(:current_attempt) { 2 }
      let(:guess1) { "RED" }
      let(:guess2) { "YELLOW" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for two accurate and one wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 3
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Three colors guessed, two at the exact position and one at the wrong position."
      end
    end

    context "third attempt,1/4 match and 2/4 wrong" do
      let(:current_attempt) { 3 }
      let(:guess1) { "RED" }
      let(:guess2) { "BLUE" }
      let(:guess3) { "GREEN" }
      let(:guess4) { "ORANGE" }

      it "returns a message for one accurate and two wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 3
        expect(view.next_attempt).to eq 4
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Three colors guessed, one at the exact position and two at the wrong position."
      end
    end

    context "fourth attempt, 1/4 match and 3/4 wrong" do
      let(:current_attempt) { 4 }
      let(:guess1) { "RED" }
      let(:guess2) { "BLUE" }
      let(:guess3) { "YELLOW" }
      let(:guess4) { "GREEN" }

      it "returns a message for one accurate and three wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq false
        expect(view.current_attempt).to eq 4
        expect(view.next_attempt).to eq 5
        expect(view.error_message).to eq nil
        expect(view.message).to eq  "You lost, ran out of turns."
      end
    end

    context "fourth attempt, 3/4 match and 1/4 wrong" do
      let(:current_attempt) { 4 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "RED" }

      it "returns a message for three accurate and one wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq false
        expect(view.current_attempt).to eq 4
        expect(view.next_attempt).to eq 5
        expect(view.error_message).to eq nil
        expect(view.message).to eq  "You lost, ran out of turns."
      end
    end

    context "fourth attempt, 2/4 match and 2/4 wrong" do
      let(:current_attempt) { 4 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "YELLOW" }
      let(:guess4) { "BLUE" }

      it "returns a message for two accurate and two wrong color guesses" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq false
        expect(view.current_attempt).to eq 4
        expect(view.next_attempt).to eq 5
        expect(view.error_message).to eq nil
        expect(view.message).to eq  "You lost, ran out of turns."
      end
    end
  end

  describe "cases: incorrect guess" do
    context "first attempt, incorrect guess" do
      let(:current_attempt) { 1 }
      let(:guess1) { "ORANGE" }
      let(:guess2) { "PURPLE" }
      let(:guess3) { "PURPLE" }
      let(:guess4) { "ORANGE" }

      it "returns an incorrect message" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq nil
        expect(view.message).to eq  "Incorrect guess."
      end
    end
  end

  describe "cases: exact position and nil" do
    context "first attempt, 3/4 match" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { nil }

      it "returns invalid input" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 1
        expect(view.error_message).to eq "Invalid input, try again!"
        expect(view.message).to eq  nil
      end
    end

    context "first attempt, 2/4 match" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { nil }
      let(:guess4) { nil }

      it "returns invalid input" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 1
        expect(view.error_message).to eq "Invalid input, try again!"
        expect(view.message).to eq  nil
      end
    end

    context "first attempt, 1/4 match" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { nil }
      let(:guess3) { nil }
      let(:guess4) { nil }

      it "returns invalid input" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 1
        expect(view.error_message).to eq "Invalid input, try again!"
        expect(view.message).to eq  nil
      end
    end
  end

  describe "wrong input" do
    context "first attempt, wrong input" do
      let(:current_attempt) { 2 }
      let(:guess1) { "R" }
      let(:guess2) { "G" }
      let(:guess3) { "B" }
      let(:guess4) { "Y" }

      it "returns invalid input" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq "Invalid input, try again!"
        expect(view.message).to eq nil
      end
    end

    context "first attempt, incomplete guess value" do
      let(:current_attempt) { 2 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "" }

      it "returns invalid input" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq "Invalid input, try again!"
        expect(view.message).to eq nil
      end
    end
  end

  xdescribe "looses all guess chances" do
    context "when empty string" do
      let(:current_attempt) { 4 }
      let(:guess1) { "" }
      let(:guess2) { "" }
      let(:guess3) { "" }
      let(:guess4) { "" }

      it "looses all the chances" do
        subject = described_class.new(params)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 4
        expect(view.next_attempt).to eq 3
        expect(view.error_message).to eq "Empty input, try again!"
        expect(view.message).to eq nil
      end
    end
  end

  xdescribe "first guess, empty strings" do
    let(:current_attempt) { 1 }
    let(:guess1) { "" }
    let(:guess2) { "" }
    let(:guess3) { "" }
    let(:guess4) { "" }

    it "lets player retry" do
      subject = described_class.new(params)
      view = subject.view

      expect(view.chances).to eq 4
      expect(view.not_lost).to eq true
      expect(view.current_attempt).to eq 1
      expect(view.next_attempt).to eq 0
      expect(view.error_message).to eq "Empty input, try again!"
      expect(view.message).to eq nil
    end
  end

  describe "initial game state" do
    it "has correct state" do
      params = {
        current_attempt: 0,
        code1: "RED",
        code2: "GREEN",
        code3: "BLUE",
        code4: "YELLOW",
      }

      subject = described_class.new(params)
      view = subject.view

      expect(view.chances).to eq 4
      expect(view.not_lost).to eq true
      expect(view.current_attempt).to eq 0
      expect(view.next_attempt).to eq 1
      expect(view.error_message).to eq nil
      expect(view.message).to eq nil
    end
  end
end
