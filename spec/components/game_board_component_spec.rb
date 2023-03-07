require "rails_helper"

RSpec.describe GameBoardComponent, type: :component do
  let(:game) {
    Game.new(id: 1, passcode: %w(RED RED GREEN GREEN).to_json)
  }
  let(:attempts) {
    [
      Attempt.new(values: %w(BLUE YELLOW ORANGE PURPLE)),
      Attempt.new(values: %w(BLUE YELLOW ORANGE RED))
    ]
  }
  let(:game_board) { GameBoardComponent.new(game: game, attempts: attempts )}

  it "renders game board components" do
    render_inline game_board

    aggregate_failures do
      expect(page.find(".secret-row")).to have_text "????", exact: true
      expect(page.all(".guess-chances").map(&:text)).to eq (1..10).to_a.map(&:to_s).reverse

      expect(page.find(".color-picker")).to have_selector(".bg-red")
      expect(page.find(".color-picker")).to have_selector(".bg-orange")
      expect(page.find(".color-picker")).to have_selector(".bg-yellow")
      expect(page.find(".color-picker")).to have_selector(".bg-green")
      expect(page.find(".color-picker")).to have_selector(".bg-blue")
      expect(page.find(".color-picker")).to have_selector(".bg-purple")

      expect(page).to have_button("Check")

      game_board.guesses.each do |guess_row|
        expect(page.find(".guess-row#{[guess_row]}").all(".guess-rating").count).to eq 4
      end

      first_guesses = attempts.first.values
      first_guesses.each do |guess|
        expect(page.find(".guess-row[data-number=1]")).to have_selector(".bg-#{guess.downcase}")
      end

      second_guesses = attempts.fetch(1).values
      second_guesses.each do |guess|
        expect(page.find(".guess-row[data-number=2]")).to have_selector(".bg-#{guess.downcase}")
      end
    end
  end
end
