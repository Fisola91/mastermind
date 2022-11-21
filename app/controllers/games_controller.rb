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
      # game.uniq.length != 4 ? "Not unique" : redirect_to game_path(game)
    end
  end

  def create
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.create!(passcode: ValidColor.passcode)
      codebreaker = Codebreaker.create!(mode: params[:codebreaker], player_id: player.id, game_id: game.id)
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



# binding.pry
      # NEXT ACTION: HOW TO DIFFERENTIATE BETWEEN COMPUTER AND PLAYER ID
      # THE COMPUER NEEDS TO UNDERSTAND PLAYER MODE

      # create a model that has both codemaker and codebreaker
      # "When a player signin" ask if he/she wants to be a codebreaker or codemaker. make it a b
      # if codemaker, direct to where th player will set the code
      # in the show controller, indicate that the player is a codemkaer by saying mode.find_by(:codemaker)

      #IF playermode = true if player_passcode
       #game.passcode.split




# HOW THE GAME WORKS

# 1. Player sign in
# 2. The player click on start a new game(in a form format), submitted to the create action which automatically
     # created a passcode and redirect to the show page(show action)
# 3. On the show page, no attempt yet. Once an attempt is made, it triggers the create action
     # in the attempt controller and redirect back to the show page to display the feedback

# WHEN THE PLAYER WANT TO BE THE CODEMAKER

# 1. Select codemaker
# 2. It will take you to where the code will be set
# 3. Once the code is set, click on submit
# 4. it should trigger an action that will convert the code to an array and display the show page, and automatically make attempt on the same show page.

# def codemaker
  # if session[:currrent_player_id]
    # player = Player.find(session[:current_player_id])
    # game = Game.create!(passcode: params[:passcode])
  #end
#end

# def create
  #elseif codemaker

#end
