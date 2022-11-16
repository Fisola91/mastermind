# require "./app/web_ui"
require "./app/components/web_submit_component"
require "./app/components/web_ui_component"
require "ostruct"
require "pry"

class GamesController < ApplicationController
  def index
    action = WebUiComponent.new(view: @view)
    @view = action
    # @player = Player.find(session[:current_player_id])
  end

  # def new
  #   # passcode = ValidColor.passcode
  #   # redirect_to "/game/#{passcode[0]}/#{passcode[1]}/#{passcode[2]}/#{passcode[3]}?current_attempt=0"
  #   redirect_to  games_path
  # end

  def create
    if session[:current_player_id]
      game = Game.create!(passcode: ValidColor.passcode)
      redirect_to game_path(game)
    end
  end

  def show
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      # @game = Game.find(params[:game_id])
      action = WebSubmitComponent.new(params: params, view: @view, player: @player, game: @game)
      @view = action.view
      @params = params
    else
      render plain: "Unauthorized"
    end
  end
end
