class RpsGamesController < ApplicationController
  before_action :clear_cache, :only => [:new]
  
  def create
    response = RockPaperScissors.new(params[:player_choice]).play
    if response[:success].present?
      set_success_cache(response)
    else
      set_failure_cache(response)
    end
    redirect_to display_rps_games_url
  end

  private

  def clear_cache
    ['success', 'message', 'result', 'player-move', 'server-move'].each do |key|
      Rails.cache.delete(key)
    end
  end

  def set_success_cache(response)
    Rails.cache.write('success', response[:success])
    Rails.cache.write('message', response[:message])
    Rails.cache.write('result', response[:data][:result])
    Rails.cache.write('player-move', response[:data][:player_move])
    Rails.cache.write('server-move', response[:data][:server_move])
  end

  def set_failure_cache(response)
    Rails.cache.write('success', response[:success])
    Rails.cache.write('message', response[:message])
  end

end

