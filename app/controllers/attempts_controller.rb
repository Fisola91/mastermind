class AttemptsController < ApplicationController
  def create
    if session[:current_player_id]
      @player = Player.find(session[:current_player_id])
      game = Game.find(params[:id])
      guess = [
        params.dig("attempts", previous_attempt, "guess1"),
        params.dig("attempts", previous_attempt, "guess2"),
        params.dig("attempts", previous_attempt, "guess3"),
        params.dig("attempts", previous_attempt, "guess4")
      ]
      @attempt = Attempt.create(
        game: game,
        player: player,
        values: guess
        )
        redirect_to game_path(game)
    end
  end
end
