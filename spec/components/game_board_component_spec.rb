# frozen_string_literal: true

require "rails_helper"

RSpec.describe GameBoardComponent, type: :component do
  #pending "add some examples to (or delete) #{__FILE__}"
  let(:passcode) { %w(red red green green)}
  let(:attempts) {
    [
      Attempt.new(values: %w(blue yellow orange purple))
    ]
  }
  let(:feedback) { GameBoardComponent.new(game: passcode, attempts: attempts )}

  it "returns guess number 10 - 1" do
    expect(feedback.guesses).to have_text((1..10).to_a.reverse)
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
