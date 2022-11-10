require "rails_helper"

feature "The guess page" do
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
  scenario "make your guesses with the valid color cobination" do
    visit("/")
    click_on("Start a new game")
    expect(page).to have_content("Guess!")
    #expect(page).to have_content("Attempt: #{@view.current_attempt.to_i + 1}/#{@view.chances}")

    # fill_in(params["attempts"]["guess1"])
    #expect(page).to have_select("attempts[cureent_attempt -1][guess1]", :option =>
                                    # "Red", "Orange", "Yellow", "Green", "Blue", "Purple")
    # select("red", from: "color")

  end
end
