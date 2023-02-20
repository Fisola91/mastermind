require "pry"
require "./app/mini_max"
require "./app/constant_variable"
require "./app/web_ui"
class GamesController < ApplicationController
  def index
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
    end
    @component = WebUiComponent.new
    @game_board = GameBoardComponent.new
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

      if passcode_colors.length == 4
        computer_player = Player.find_or_create_by!(
          name: "Computer"
        )

        mini_max = MiniMax.new(passcode: passcode_colors, colors: WebUI.new.colors.map(&:upcase))
        mini_max.play
        mini_max.guess_array.each do |guess|
          Attempt.create!(
            game: game,
            player: computer_player,
            values: guess
          )
          if guess == passcode_colors
            break
          end
        end
        redirect_to game_path(game)
      else
        begin
          ValidateInput.call(passcode_colors)
        rescue UnknownColorError
          return render plain: "Invalid attempt: contains unknown color"
        rescue NumberOfColorsError
          return render plain: "Invalid attempt: wrong number of colors submitted"
        end
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
