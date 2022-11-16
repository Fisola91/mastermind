# require "./app/web_ui"
require "./app/components/web_submit_component"
require "./app/components/web_ui_component"
require "ostruct"
require "pry"

class WebGamesController < ApplicationController
  def index
    action = WebUiComponent.new(view: @view)
    @view = action
  end

  def new
    # passcode = ValidColor.passcode
    # redirect_to "/game/#{passcode[0]}/#{passcode[1]}/#{passcode[2]}/#{passcode[3]}?current_attempt=0"
    redirect_to  player_guess_web_games_path
  end

  def player_guess
    action = WebSubmitComponent.new(params: params, view: @view)
    @view = action.view
    @params = params
    # binding.pry
  end
end
