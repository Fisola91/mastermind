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


  it "allows a player to play and guess a color at the exact position on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[0], from: "color-1"
    select color_difference[0], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("One color guessed at the exact position.")
  end

  it "allows a player to play and guess two colors at the exact position on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Two colors guessed at the exact position.")
  end

  it "allows a player to play and guess one color at the wrong position on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[1], from: "color-1"
    select color_difference[1], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("One color guessed at the wrong position.")
  end

 it "allows a player to play and guess three colors at the exact position on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select select_values[2], from: "color-3"
    select color_difference[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Three colors guessed at the exact position.")
  end

  it "allows a player to run out of attempt" do
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
    select select_values[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Four colors guessed, three at the exact position and one at the wrong position.")
    expect(page).to have_text("You are playing as Tester")
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 2/4")
    expect(page).to have_text("Attempt 1: #{passcode_colors[0]}, #{passcode_colors[1]}, #{passcode_colors[2]}, #{passcode_colors[0]}")
    expect(page).to have_text("Your guess")

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select select_values[2], from: "color-3"
    select select_values[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Four colors guessed, three at the exact position and one at the wrong position.")
    expect(page).to have_text("You are playing as Tester")
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 3/4")
    expect(page).to have_text("Attempt 2: #{passcode_colors[0]}, #{passcode_colors[1]}, #{passcode_colors[2]}, #{passcode_colors[0]}")
    expect(page).to have_text("Your guess")

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select select_values[2], from: "color-3"
    select select_values[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Four colors guessed, three at the exact position and one at the wrong position.")
    expect(page).to have_text("You are playing as Tester")
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 4/4")
    expect(page).to have_text("Attempt 3: #{passcode_colors[0]}, #{passcode_colors[1]}, #{passcode_colors[2]}, #{passcode_colors[0]}")
    expect(page).to have_text("Your guess")

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select select_values[2], from: "color-3"
    select select_values[0], from: "color-4"

    click_on "Check"

    expect(page).to have_text("You lost, ran out of turns.")
  end

  it "allows a player to make an incorrect guess" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select color_difference[1], from: "color-1"
    select color_difference[0], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Incorrect guess.")
  end

  it "allows a player to get an invalid input as a reponse" do
    visit "/"
    click_on "codebreaker"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_content("You are playing as Tester")
    click_on "codebreaker"
    expect(page).to have_content("Guess!")
    expect(page).to have_content("Attempt: 1/4")
    expect(page).to have_content("Your guess")

    passcode_colors = JSON.parse(Game.last.passcode)
    select_values = passcode_colors.map(&:downcase)

    select select_values[1], from: "color-1"
    select select_values[2], from: "color-2"
    select select_values[0], from: "color-3"


    click_on "Check"

    expect(page).to have_content("Invalid attempt: contains unknown color")
  end

  it "allows a player to play and guess two colors at the wrong position on second attempt" do
    visit "/"
    click_on "codebreaker"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_content("You are playing as Tester")
    click_on "codebreaker"
    expect(page).to have_content("Guess!")
    expect(page).to have_content("Attempt: 1/4")
    expect(page).to have_content("Your guess")

    passcode_colors = JSON.parse(Game.last.passcode)
    select_values = passcode_colors.map(&:downcase)

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values
    color_difference_upcase = color_difference.map(&:upcase)

    select select_values[1], from: "color-1"
    select color_difference[0], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_content("One color guessed at the wrong position.")
    expect(page).to have_text("You are playing as Tester")
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 2/4")
    expect(page).to have_text("Attempt 1: #{passcode_colors[1]}, #{color_difference_upcase[0]}, #{color_difference_upcase[0]}, #{color_difference_upcase[1]}")
    expect(page).to have_text("Your guess")

    select select_values[1], from: "color-1"
    select select_values[0], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_content("Two colors guessed at the wrong position.")
  end

  it "allows a player to play and guess three colors at the wrong position on second attempt" do
    visit "/"
    click_on "codebreaker"
    fill_in "player name", with: "Tester"
    click_on "Start player session"
    expect(page).to have_content("You are playing as Tester")
    click_on "codebreaker"
    expect(page).to have_content("Guess!")
    expect(page).to have_content("Attempt: 1/4")
    expect(page).to have_content("Your guess")

    passcode_colors = JSON.parse(Game.last.passcode)
    select_values = passcode_colors.map(&:downcase)

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values
    color_difference_upcase = color_difference.map(&:upcase)

    select select_values[1], from: "color-1"
    select color_difference[0], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_content("One color guessed at the wrong position.")
    expect(page).to have_text("You are playing as Tester")
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 2/4")
    expect(page).to have_text("Attempt 1: #{passcode_colors[1]}, #{color_difference_upcase[0]}, #{color_difference_upcase[0]}, #{color_difference_upcase[1]}")
    expect(page).to have_text("Your guess")

    select select_values[1], from: "color-1"
    select select_values[0], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_content("Two colors guessed at the wrong position.")
    expect(page).to have_text("You are playing as Tester")
    expect(page).to have_text("Guess!")
    expect(page).to have_text("Attempt: 3/4")
    expect(page).to have_text("Attempt 2: #{passcode_colors[1]}, #{passcode_colors[0]}, #{color_difference_upcase[0]}, #{color_difference_upcase[1]}")
    expect(page).to have_text("Your guess")

    select select_values[1], from: "color-1"
    select select_values[0], from: "color-2"
    select select_values[3], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_content("Three colors guessed at the wrong position.")
  end

  it "allows a player to play and guess four colors at the wrong position on first attempt" do
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

    select select_values[1], from: "color-1"
    select select_values[3], from: "color-2"
    select select_values[0], from: "color-3"
    select select_values[2], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Four colors guessed at the wrong position.")
  end

  it "allows a player to play and guess one exact and one wrong color on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[0], from: "color-1"
    select select_values[2], from: "color-2"
    select color_difference[0], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Two colors guessed, one at the exact position and one at the wrong position.")
  end

  it "allows a player to play and guess two exact and one wrong color on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[0], from: "color-1"
    select select_values[1], from: "color-2"
    select select_values[3], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Three colors guessed, two at the exact position and one at the wrong position.")
  end

  it "allows a player to play and guess two partial and one exact color on first attempt" do
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

    valid_colors = ValidColor.select(:colors).first[:colors]
    select_colors = valid_colors.map(&:downcase)

    color_difference = select_colors - select_values

    select select_values[0], from: "color-1"
    select select_values[2], from: "color-2"
    select select_values[3], from: "color-3"
    select color_difference[1], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Three colors guessed, one at the exact position and two at the wrong position.")
  end

  it "allows a player to play and guess three partial and one exact color on first attempt" do
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
    select select_values[2], from: "color-2"
    select select_values[3], from: "color-3"
    select select_values[1], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Four colors guessed, one at the exact position and three at the wrong position.")
  end

  it "allows a player to play and guess two partial and two exact color on first attempt" do
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
    select select_values[3], from: "color-3"
    select select_values[1], from: "color-4"

    click_on "Check"

    expect(page).to have_text("Four colors guessed, two at the exact position and two at the wrong position.")
  end
end
