# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameBoardComponent, type: :component do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:game) {
    Game.new(passcode: %w(red red green green).to_json)
  }
  let(:attempts) {
    [
      Attempt.new(values: %w(blue yellow orange purple)),
      Attempt.new(values: %w(blue yellow orange red))
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

      expect(page).to have_text("Check")
      expect(page).to have_text("✓")

      bg_class = attempts.first.values
      expect(page.find(".guess-row[data-number=1]").find(".bg-#{bg_class[0]}")["data-number"]).to eq "0"
      expect(page.find(".guess-row[data-number=1]").find(".bg-#{bg_class[1]}")["data-number"]).to eq "1"
      expect(page.find(".guess-row[data-number=1]").find(".bg-#{bg_class[2]}")["data-number"]).to eq "2"
      expect(page.find(".guess-row[data-number=1]").find(".bg-#{bg_class[3]}")["data-number"]).to eq "3"

      bg_class = attempts[1].values
      expect(page.find(".guess-row[data-number=2]").find(".bg-#{bg_class[0]}")["data-number"]).to eq "0"
      expect(page.find(".guess-row[data-number=2]").find(".bg-#{bg_class[1]}")["data-number"]).to eq "1"
      expect(page.find(".guess-row[data-number=2]").find(".bg-#{bg_class[2]}")["data-number"]).to eq "2"
      expect(page.find(".guess-row[data-number=2]").find(".bg-#{bg_class[3]}")["data-number"]).to eq "3"

    end
  end
end
