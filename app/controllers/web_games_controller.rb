require "./app/web_ui"
require "./app/web_submit"
class WebGamesController < ApplicationController
  def index
    @view = WebUI.new
  end

  def new_game
    passcode = ["RED", "GREEN", "BLUE", "YELLOW"]
    redirect_to "/game/#{passcode[0]}/#{passcode[1]}/#{passcode[2]}/#{passcode[3]}?current_attempt=0"
  end

  def guess
    action = WebSubmit.new(params)
    @view = action.view
    @params = params
  end
end
