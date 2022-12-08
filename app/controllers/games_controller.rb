require "pry"
class GamesController < ApplicationController
  def index
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
    end
    @component = WebUiComponent.new
  end

  def new
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      Game.new
    end
  end

  def player_passcode
    # computer_tries = []
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      passcode = params[:passcode].upcase.split(" ").to_s
      game = Game.create!(passcode: passcode)
      codemaker = Codemaker.create!(
        player: player,
        game: game
      )
      passcode_colors = JSON.parse(game.passcode)

      if passcode_colors.uniq.length == 4
        computer_player = Player.find_or_create_by!(
          name: "Computer"
        )

        while game.attempts.count < ChancesAndGuesses::CHANCES
          guess = ValidColor.passcode

          Attempt.create!(
            game: game,
            player: computer_player,
            values: guess
          )

          if guess == passcode
            break
          end
        end

        redirect_to game_path(game)
      else
        render plain: "You must enter unique set of colors."
      end
    else
      redirect_to new_session_path
    end
  end

  def create
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: ValidColor.passcode)
      codebreaker = Codebreaker.create!(
        player: player,
        game: game
      )
      redirect_to game_path(game)
    else
      redirect_to new_session_path
    end
  end

  def show
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      game = Game.find(params[:id])
      @component = WebSubmitComponent.new(game: game)
    end
  end

  private

  # Still keep this logic here
  def computer_guesses
    computer_tries = []
    4.times { computer_tries << ValidColor.passcode }
    computer_tries.each do |computer_generated_code|
      computer_generated_code
    end
  end

  # 1. When you submit your code, that is when the crete action in the attempt controller get activated

  # PSEUDOCODE
  # 1. When player set code, redirect to the show page where the attempt will be made
  # 2. Automatic selection for each attempt
  # 2.b Auto click when a form is filled
  # 3. Each attempt should give a feedback before moving to the next attempt.
  # 4. Repeat this untill the chances is exhausted or computer guesses the code rightly
end
