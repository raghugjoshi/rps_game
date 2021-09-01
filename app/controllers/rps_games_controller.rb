class RpsGamesController < ApplicationController

  def create
    response = RockPaperScissors.new(params[:player_choice]).play
    if response[:success].present?
      redirect_to(display_rps_games_url + "?success=#{response[:success]}&message=#{response[:message]}&result=#{response[:data][:result]}&player-move=#{response[:data][:player_move]}&server-move=#{response[:data][:server_move]}")
    else
      redirect_to(display_rps_games_url + "?success=#{response[:success]}&message=#{response[:message]}")
    end
  end

end

