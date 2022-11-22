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
      Game.new
    end
  end

  def player_passcode
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: params[:passcode].upcase.split(" ").to_s)
      codebmaker = Codemaker.create!(
        player: player,
        game: game
      )
      if JSON.parse(game.passcode).uniq.length == 4
        redirect_to game_path(game)
      else
        render plain: "You must enter a unique set of colors."
      end
    end
  end

  def create
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: ValidColor.passcode)
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
      codebreaker = Codebreaker.find_by(game: game)
      codemaker = Codemaker.find_by(game: game)
      codebreaker || codemaker ?  @component = WebSubmitComponent.new(game: game) : nil
    end
  end
end
