require "pry"
require "./app/mini_max"
require "./app/constant_variable"
require "./app/web_ui"
class GamesController < ApplicationController
  def index
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
    end

    game = Game.new(passcode: %w(red red green green))
    attempts = [
      Attempt.new(values: %w(blue yellow orange purple)),
      Attempt.new(values: %w(blue yellow orange red)),
      Attempt.new(values: %w(red blue red orange)),
      Attempt.new(values: %w(red yellow purple green)),
      Attempt.new(values: %w(red yellow green green)),
      Attempt.new(values: %w(red blue green red)),
      Attempt.new(values: %w(green green red red))
    ]
    @game_board = GameBoardComponent.new(
      game: game,
      attempts: attempts
    )
  end

  def new
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      Game.new
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
