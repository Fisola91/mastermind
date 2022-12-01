require "rails_helper"

RSpec.describe "guessing game" do
  before do
    ValidColor.create!(colors: %w(RED ORANGE YELLOW GREEN BLUE PURPLE))
  end

  it "allows a player to sign in" do
    visit "/"
    click_on "codebreaker"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text("You are playing as Tester")
  end

  it "allows a player to sign out" do
    visit "/"
    click_on "codebreaker"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text("You are playing as Tester")

    click_on "Sign out"
    expect(page).to_not have_text("Tester")
  end

  it "allows a player to play and win on first attempt" do
    visit "/"
    click_on "codebreaker"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text("You are playing as Tester")
    click_on "codebreaker"
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 1/4")
    expect(page).to have_text("Your guess")

    passcode_colors = JSON.parse(Game.last.passcode)
    select_values = passcode_colors.map(&:downcase)

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select select_values[2], from: "color-3"
    select select_values[3], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Congratulations!")
  end
end
