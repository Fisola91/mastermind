require "pry"
require "./app/minimax"
require "./app/constant_variable"
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
          @guess = MiniMax.new(passcode: passcode_colors).play
          # end
          Attempt.create!(
            game: game,
            player: computer_player,
            values: @guess
          )

          if @guess == passcode
            "break"
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
      game = Game.create!(passcode: ValidColor.passcode.map(&:upcase))
      codebreaker = Codebreaker.create!(
        player: player,
        game: game
      )
      p game

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
end
