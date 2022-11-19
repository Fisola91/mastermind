# require "./app/web_ui"
require "./app/components/web_submit_component"
require "./app/components/web_ui_component"
require "ostruct"
require "pry"

class GamesController < ApplicationController
  def index
    action = WebUiComponent.new(view: @view)
    @view = action
  end


  def new
    if session[:current_player_id]
      game = Game.create!(passcode: ValidColor.passcode)
      redirect_to game_path(game)
    end
  end

  def show
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      game = Game.find(params[:id])
      action = WebSubmitComponent.new(params: params, view: @view, player: @player, game: game)
      @view = action.view
      @params = params
    end
  end

  def update
    if session[:current_player_id]
      game = Game.find(params[:id])
      player = Player.find(session[:current_player_id])
      guess = [
        params.dig("attempts", 0, "guess1"),
        params.dig("attempts", 0, "guess2"),
        params.dig("attempts", 0, "guess3"),
        params.dig("attempts", 0, "guess4")
      ]
      if Attempt.update!(
        player: player,
        game: game,
        values: guess
        )
        redirect_to game_path(game)
      end
    end
  end

  # private

  # def previous_attempt
  #   params.dig("current_attempt")
  #   # (current_attempt - 1).to_s
  # end
end
