require "rails_helper"

RSpec.describe "computer guess" do

  it "allows a player to sign in" do
    visit "/"
    click_on "codemaker"
    fill_in "Passcode", with: "orange red purple yellow"
    click_on "Submit"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_content("You are playing as Tester")
  end

  it "allows a player to sign out" do
    visit "/"
    click_on "codemaker"
    fill_in "Passcode", with: "orange red purple yellow"
    click_on "Submit"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text("You are playing as Tester")

    click_on "Sign out"
    expect(page).to_not have_text("Tester")
  end
end
