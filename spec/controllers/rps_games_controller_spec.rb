require 'rails_helper'

describe RpsGamesController, type: :controller do
  
  describe '#create' do
    it do
      expect(:post => "/rps_games").to route_to(
        :controller => "rps_games",
        :action => 'create'
      )
    end

    it 'responds with HTTP 302' do
      create_params = { player_choice: 'rock'}
      post :create, params: create_params
      expect(response.status).to eq 302
    end

    describe 'player winning' do
      context "when player's choice is #scissors and server's choice is #paper" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'scissors'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('paper')

            expected_response = {
             success: true, message: 'Wow!! You Won. Congratulations.', result: 'Player Won', player_move: 'Scissors', server_move: 'Paper'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end

      context "when player's choice is #paper and server's choice is #rock" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'paper'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('rock')

            expected_response = {
             success: true, message: 'Wow!! You Won. Congratulations.', result: 'Player Won', player_move: 'Paper', server_move: 'Rock'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end

      context "when player's choice is #rock and server's choice is #scissors" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'rock'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('scissors')

            expected_response = {
             success: true, message: 'Wow!! You Won. Congratulations.', result: 'Player Won', player_move: 'Rock', server_move: 'Scissors'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end
    end

    describe 'server winning' do
      context "when player's choice is #paper and server's choice is #scissors" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'paper'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('scissors')

            expected_response = {
             success: true, message: "Oh!! Server won this time. Don't worry. Better luck next time.", result: 'Server Won', player_move: 'Paper', server_move: 'Scissors'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end

      context "when player's choice is #rock and server's choice is #paper" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'rock'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('paper')

            expected_response = {
             success: true, message: "Oh!! Server won this time. Don't worry. Better luck next time.", result: 'Server Won', player_move: 'Rock', server_move: 'Paper'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end

      context "when player's choice is #scissors and server's choice is #rock" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'scissors'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('rock')

            expected_response = {
             success: true, message: "Oh!! Server won this time. Don't worry. Better luck next time.", result: 'Server Won', player_move: 'Scissors', server_move: 'Rock'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end
    end

    describe 'tie' do
      context "when player's choice is #rock and server's choice is #rock" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'rock'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('rock')

            expected_response = {
             success: true, message: "Oh!!. There is a Tie!!. Try again. All the best.", result: 'Tie', player_move: 'Rock', server_move: 'Rock'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end

      context "when player's choice is #scissors and server's choice is #scissors" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'scissors'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('scissors')

            expected_response = {
             success: true, message: "Oh!!. There is a Tie!!. Try again. All the best.", result: 'Tie', player_move: 'Scissors', server_move: 'Scissors'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end

      context "when player's choice is #paper and server's choice is #paper" do
          it 'sets cache with the game status' do
            create_params = { player_choice: 'paper'}
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('paper')

            expected_response = {
             success: true, message: "Oh!!. There is a Tie!!. Try again. All the best.", result: 'Tie', player_move: 'Paper', server_move: 'Paper'
            }
            post :create, params: create_params
            cache_expectations(expected_response)
          end
      end
    end

    describe 'invalid choice' do
      context "when player's choice is #invalid" do
        it 'sets cache with the game status' do
          create_params = { player_choice: 'invalid'}
          post :create, params: create_params
          expect(Rails.cache.read('success')).to eq(false)
          expect(Rails.cache.read('message')).to eq('Invalid choice. Options should be eiether Rock, Paper or Scissors. Please try again')
          expect(Rails.cache.read('data')).to eq(nil)
        end
      end
    end
  end

  def cache_expectations(expected_response)
    expect(Rails.cache.read('success')).to eq(expected_response[:success])
    expect(Rails.cache.read('player-move')).to eq(expected_response[:player_move])
    expect(Rails.cache.read('server-move')).to eq(expected_response[:server_move])
    expect(Rails.cache.read('result')).to eq(expected_response[:result])
    expect(Rails.cache.read('message')).to eq(expected_response[:message])    
  end

end
