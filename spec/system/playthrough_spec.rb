require "rails_helper"

RSpec.describe "signed user plays a game" do
  let(:game) {
    Game.new(id: 1, passcode:%w(RED ORANGE YELLOW GREEN).to_json)
  }

  let(:attempts) {
    [
      Attempt.new(values: %w(RED ORANGE YELLOW BLUE))
    ]
  }

  it "can log in, and win the game" do
    allow(ValidColors).to receive(:four_random_colors)
      .and_return(%w(RED ORANGE YELLOW GREEN))

    visit "/"
    fill_in "Player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text "You are playing as Tester"
    expect(page).to have_button "Sign out"
    click_on "New game"
    expect(page).to have_css(".board")


    find(".color-picker div[data-color=red]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")

    find(".color-picker div[data-color=orange]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")

    find(".color-picker div[data-color=yellow]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")

    find(".color-picker div[data-color=green]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='3']")

    find(".color-picker div[data-color=blue]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='3']")

    click_on "Check"

    expect(find(".board")).to have_text("Congratulations!")

    expect(find(".guess-row[data-number='1']")).to have_css(".guess-rating.bg-green", count: 4)
  end

  it "can log in, and loose the game" do
    allow(ValidColors).to receive(:four_random_colors)
      .and_return(%w(RED ORANGE YELLOW GREEN))

    allow_any_instance_of(GameBoardComponent).to receive(:guess_attempts).and_return(1)

    object = GameBoardComponent.new(
      game: game,
      attempts: attempts)

    visit "/"
    fill_in "Player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text "You are playing as Tester"
    expect(page).to have_button "Sign out"
    expect(page).to have_button "How to play"
    click_on "New game"
    expect(page).to have_css(".board")


    find(".color-picker div[data-color=red]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")

    find(".color-picker div[data-color=orange]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")

    find(".color-picker div[data-color=yellow]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")

    find(".color-picker div[data-color=blue]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-blue[data-number='3']")

    find(".color-picker div[data-color=blue]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-blue[data-number='3']")

    click_on "Check"

    expect(find(".board")).to have_content("Sorry, you've lost! It was a bit difficult")

    expect(find(".guess-row[data-number='1']")).to have_css(".guess-rating.bg-green", count: 3)
  end

  it "can log in, and disabled the check button when the board has just been rendered" do
    visit "/"
    fill_in "Player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text "You are playing as Tester"
    expect(page).to have_button "Sign out"
    click_on "New game"
    expect(page).to have_css(".board")

    click_on "Check"

    expect(page).to have_button("Check", disabled: true)
    expect(page).not_to have_content("Invalid attempt: contains unknown color")
  end

  it "can log in, and disabled the check button on the third guess" do
    allow(ValidColors).to receive(:four_random_colors)
      .and_return(%w(RED ORANGE YELLOW GREEN))

    visit "/"
    fill_in "Player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text "You are playing as Tester"
    expect(page).to have_button "Sign out"
    click_on "New game"
    expect(page).to have_css(".board")


    find(".color-picker div[data-color=red]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")

    find(".color-picker div[data-color=orange]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")

    find(".color-picker div[data-color=yellow]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")

    find('.guess-check').click

    expect(page).to have_button("Check", disabled: true)
    expect(page).not_to have_content("Invalid attempt: contains unknown color")
  end

  it "can log in, win the game an disabled all colors" do
    allow(ValidColors).to receive(:four_random_colors)
      .and_return(%w(RED ORANGE YELLOW GREEN))

    visit "/"
    fill_in "Player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text "You are playing as Tester"
    expect(page).to have_button "Sign out"
    click_on "New game"
    expect(page).to have_css(".board")


    find(".color-picker div[data-color=red]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")

    find(".color-picker div[data-color=orange]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")

    find(".color-picker div[data-color=yellow]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")

    find(".color-picker div[data-color=green]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='3']")

    find(".color-picker div[data-color=blue]").click
    expect(find(".current-attempt")).to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).to have_selector(".bg-orange[data-number='1']")
    expect(find(".current-attempt")).to have_selector(".bg-yellow[data-number='2']")
    expect(find(".current-attempt")).to have_selector(".bg-green[data-number='3']")

    click_on "Check"

    expect(find(".board")).to have_text("Congratulations!")

    expect(find(".guess-row[data-number='1']")).to have_css(".guess-rating.bg-green", count: 4)
    
    find(".color-picker div[data-color=red]").click
    find(".color-picker div[data-color=orange]").click
    find(".color-picker div[data-color=yellow]").click
    find(".color-picker div[data-color=green]").click

    expect(find(".current-attempt")).not_to have_selector(".bg-red[data-number='0']")
    expect(find(".current-attempt")).not_to have_selector(".bg-orange[data-number='0']")
    expect(find(".current-attempt")).not_to have_selector(".bg-yellow[data-number='0']")
    expect(find(".current-attempt")).not_to have_selector(".bg-green[data-number='0']")

    expect(page).not_to have_content("Invalid attempt: contains unknown color")
  end
end
