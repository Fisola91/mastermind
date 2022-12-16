require "rails_helper"

RSpec.describe "computer guess" do
  before do
    ValidColor.create!(colors: %w(RED ORANGE YELLOW GREEN BLUE PURPLE))
  end

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

  it "allows player to play and has no matched value on first attempt" do
    visit "/"
    click_on "codemaker"
    fill_in "Passcode", with: "orange red purple yellow"
    click_on "Submit"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_text("You are playing as Tester")
    click_on "codemaker"
    fill_in "Passcode", with: "orange red purple yellow"
    click_on "Submit"

    game = Game.last
    passcode_colors = JSON.parse(game.passcode)

    attempt_1 = game.attempts[0].values
    attempt_2 = game.attempts[1].values
    attempt_3 = game.attempts[2].values
    attempt_4 = game.attempts[3].values

    expect(page).to have_text("Attempt 1: #{attempt_1[0]}, #{attempt_1[1]}, #{attempt_1[2]}, #{attempt_1[3]}")
    expect(page).to have_text("Attempt 2: #{attempt_2[0]}, #{attempt_2[1]}, #{attempt_2[2]}, #{attempt_2[3]}")
    expect(page).to have_text("Attempt 3: #{attempt_3[0]}, #{attempt_3[1]}, #{attempt_3[2]}, #{attempt_3[3]}")
    expect(page).to have_text("Attempt 4: #{attempt_4[0]}, #{attempt_4[1]}, #{attempt_4[2]}, #{attempt_4[3]}")

    expect(page).to have_text("You lost, ran out of turns.")
  end

  context "when secondattempt" do

    it "allows player to play and has one matched value on second attempt" do
      visit "/"
      click_on "codemaker"
      fill_in "Passcode", with: "orange red purple yellow"
      click_on "Submit"
      fill_in "player name", with: "Tester"
      click_on "Start player session"
      expect(page).to have_text("You are playing as Tester")
      click_on "codemaker"
      fill_in "Passcode", with: "orange red purple yellow"
      click_on "Submit"

      game = Game.last
      passcode_colors = JSON.parse(game.passcode)
      attempt = game.attempts.last

      attempt_1 = game.attempts[0].values
      attempt_2 = game.attempts[1].values
      attempt_3 = game.attempts[2].values
      attempt_4 = game.attempts[3].values

      expect(page).to have_text("Attempt 1: #{attempt_1[0]}, #{attempt_1[1]}, #{attempt_1[2]}, #{attempt_1[3]}")
      expect(page).to have_text("Attempt 2: #{passcode_colors[0]}, #{attempt_2[1]}, #{passcode_colors[2]}, #{attempt_2[3]}")
      expect(page).to have_text("Attempt 3: #{passcode_colors[0]}, #{passcode_colors[1]}, #{passcode_colors[2]}, #{attempt_3[3]}")
      expect(page).to have_text("Attempt 4: #{passcode_colors[0]}, #{passcode_colors[1]}, #{passcode_colors[2]}, #{passcode_colors[3]}")

      expect(page).to have_text("Congratulations")
    end
  end

end
