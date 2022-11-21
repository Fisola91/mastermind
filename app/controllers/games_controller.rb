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
    end
  end

  def player_passcode
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: params[:passcode].upcase.split(" ").to_s)
      redirect_to game_path(game)
    end
  end

  def create
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: ValidColor.passcode)
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
