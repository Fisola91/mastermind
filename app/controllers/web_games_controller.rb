require "./app/web_ui"
require "./app/components/web_submit_component"
require "ostruct"
class WebGamesController < ApplicationController
  def index
    @view = WebUI.new
  end

  def new_game
    passcode = ["RED", "GREEN", "BLUE", "YELLOW"]
    redirect_to "/game/#{passcode[0]}/#{passcode[1]}/#{passcode[2]}/#{passcode[3]}?current_attempt=0"
  end

  def player_guess
    action = WebSubmitComponent.new(params: params, view: @view)
    @view = action.view
    @params = params
  end
end
