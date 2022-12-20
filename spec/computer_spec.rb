require "./app/computer"
require "./app/turn"

RSpec.describe Computer do
  it "can guess a code" do
    passcode = %w(RED GREEN BLUE YELLOW)

    game = instance_double("Game")
    player = double("Player")

    # expect(game).to receive(:passcode).and_return(passcode)

    puts "The secret code is #{passcode.join(' ')}"
    computer = described_class.new(game: game, player: player)
    remaining_guesses = 12
    until remaining_guesses == 0 do
      guess = computer.guess(remaining_guesses)
      remaining_guesses -= 1

      break if guess == passcode

      turn = Turn.new(passcode: passcode)
      result = turn.guess(guess)

      right_color = result.count { |i| i == :partial}
      right_spot = result.count { |i| i == :exact }
      puts "Guess: #{guess.join(' ')}"
      puts "Right color(s) in wrong place: #{right_color}."
      puts "Right color(s) in the right place: #{right_spot}."

      computer.filter_combos(right_color, right_spot)
      puts " "
    end

    if remaining_guesses == 0
      puts "Computer lost"
    else
      puts "Computer won"
    end
  end
end
