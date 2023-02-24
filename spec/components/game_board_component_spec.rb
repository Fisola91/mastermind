# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameBoardComponent, type: :component do
  let(:game) {
    Game.new(passcode: %w(red red green green).to_json)
  }
  let(:attempts) {
    [
      Attempt.new(values: %w(blue yellow orange purple))
    ]
  }
  let(:feedback) { GameBoardComponent.new(game: game, attempts: attempts )}

  it "renders game board elements" do
    render_inline feedback

    aggregate_failures do
      expect(page.find(".secret-row")).to have_text "????", exact: true
      expect(page.all(".guess-chances").map(&:text)).to eq (1..10).to_a.map(&:to_s).reverse
      expect(page.find(".color-picker").find(".bg-red")["data-color"]).to eq "red"
      expect(page.find(".color-picker").find(".bg-orange")["data-color"]).to eq "orange"
      expect(page.find(".color-picker").find(".bg-yellow")["data-color"]).to eq "yellow"
      expect(page.find(".color-picker").find(".bg-green")["data-color"]).to eq "green"
      expect(page.find(".color-picker").find(".bg-blue")["data-color"]).to eq "blue"
      expect(page.find(".color-picker").find(".bg-purple")["data-color"]).to eq "purple"
    end
  end
end
