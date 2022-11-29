require "./app/validate_input"
class AttemptsController < ApplicationController
  def player_guesser
  end
  def create
    if session[:current_player_id]
      player = Player.find(session[:current_player_id])
      game = Game.find(params[:game_id])
      guess = params[:guess]
      p guess

      begin
        ValidateInput.call(guess)
      rescue UnknownColorError
        return render plain: "Invalid attempt: contains unknown color"
      rescue NumberOfColorsError
        return render plain: "Invalid attempt: wrong number of colors submitted"
      end

      Attempt.create!(
        game: game,
        player: player,
        values: guess
      )

      redirect_to game_path(game)
    else
      render status: :unauthorized
    end
  end
end
