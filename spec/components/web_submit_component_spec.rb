require "rails_helper"

RSpec.describe WebSubmitComponent, type: :component do
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


  context "when the guess page is displayed" do
    let(:params) do
      {
        "current_attempt"=>"0",
        "code1"=>"RED",
        "code2"=>"GREEN",
        "code3"=>"BLUE",
        "code4"=>"YELLOW"}
    end
    it "shows some text" do
      subject = described_class.new(params: params, view: @view)
      view = subject.view

      render_inline(described_class.new(params: @params, view: view))
      expect(page).to have_css("h3", text: "Guess!")
    end
  end

  describe "#view" do
    context "when make first attempt, 4/4 match" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "BLUE" }
      let(:guess4) { "YELLOW" }

      it "returns correct view values" do
        subject = described_class.new(params: params, view: @view)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq nil
        expect(view.message).to eq "Congratulations!"
      end
    end

    context "when make first attempt, 1/4 match" do
      let(:current_attempt) { 1 }
      let(:guess1) { "RED" }
      let(:guess2) { "PURPLE" }
      let(:guess3) { "ORANGE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for one accurate color guess" do
        subject = described_class.new(params: params, view: @view)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 1
        expect(view.next_attempt).to eq 2
        expect(view.error_message).to eq nil
        expect(view.message).to eq "One color guessed at the exact position."
      end
    end

    context "when make second attempt, 2/4 match" do
      let(:current_attempt) { 2 }
      let(:guess1) { "RED" }
      let(:guess2) { "GREEN" }
      let(:guess3) { "PURPLE" }
      let(:guess4) { "ORANGE" }

      it "returns a message for two accurate color guesses" do
        subject = described_class.new(params: params, view: @view)
        view = subject.view

        expect(view.chances).to eq 4
        expect(view.not_lost).to eq true
        expect(view.current_attempt).to eq 2
        expect(view.next_attempt).to eq 3
        expect(view.error_message).to eq nil
        expect(view.message).to eq  "Two colors guessed at the exact position."
      end
    end
  end
end
