require "pry"
require "./app/constant_variable"
require "./app/web_ui"
class GamesController < ApplicationController
  def index
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])

      @games = Game.joins(:codebreakers).where(codebreakers: { player_id: @player.id }) # Codebreaker.joins(:games).where(player: @player).games
    else
      redirect_to new_session_path
    end
  end

  def new
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      Game.new
    end
  end

  def rules
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
    end
  end

  def create
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: ValidColors.four_random_colors)
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
      attempts = game.attempts
      @component = GameBoardComponent.new(
        game: game,
        attempts: attempts
      )
    end
  end
end
