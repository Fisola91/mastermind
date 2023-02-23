# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameBoardComponent, type: :component do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:game) {
    Game.new(passcode: %w(red red green green).to_json)
  }
  let(:attempts) {
    [
      Attempt.new(values: %w(blue yellow orange purple))
    ]
  }
  let(:feedback) { GameBoardComponent.new(game: game, attempts: attempts )}

  it "returns guess number 10 - 1" do
    render_inline feedback

    aggregate_failures do
      expect(page.find(".secret-row")).to have_text "????", exact: true
      expect(page.all(".guess-chances").map(&:text)).to eq (1..10).to_a.map(&:to_s).reverse
    end
  end

  # feedback.code_length.times do |cell_number|
  #   it "returns an array of colors" do
  #     expect(feedback.inner_guess_class(1, cell_number)).to eq("inner-guess-cell ba b--black dib rc tc #{bg_class}")
  #   end
  # end

  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class.new(attr: "value")) { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end
