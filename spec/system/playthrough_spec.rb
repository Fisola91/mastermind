require "rails_helper"

RSpec.describe "signed user plays a game" do
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
end
