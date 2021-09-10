require 'rails_helper'

RSpec.describe RockPaperScissors, type: :model do
  describe 'RockPaperScissors' do

    describe '#play' do
      describe 'Human player winning' do
        context 'when human player chooses #Scissors and server chooses #Paper' do
          it 'player should win with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('paper')
            expected_response = {
             success: true, message: 'Wow!! You Won. Congratulations.', data: { result: 'Player Won', player_move: 'Scissors', server_move: 'Paper' }
            }
            expect(RockPaperScissors.new('scissors').play).to eq(expected_response)
          end
        end

        context 'when human player chooses #Paper and server chooses #Rock' do
          it 'player should win with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('rock')
            expected_response = {
             success: true, message: 'Wow!! You Won. Congratulations.', data: { result: 'Player Won', player_move: 'Paper', server_move: 'Rock' }
            }
            expect(RockPaperScissors.new('paper').play).to eq(expected_response)
          end
        end

        context 'when human player chooses #Rock and server chooses #Scissors' do
          it 'player should win with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('scissors')
            expected_response = {
             success: true, message: 'Wow!! You Won. Congratulations.', data: { result: 'Player Won', player_move: 'Rock', server_move: 'Scissors' }
            }
            expect(RockPaperScissors.new('rock').play).to eq(expected_response)
          end
        end
      end

      describe 'Server winning' do

        context 'when human player chooses #Paper and server chooses #Scissors' do
          it 'player should win with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('scissors')
            expected_response = {
             success: true, message: "Oh!! Server won this time. Don't worry. Better luck next time.", data: { result: 'Server Won', player_move: 'Paper', server_move: 'Scissors' }
            }
            expect(RockPaperScissors.new('paper').play).to eq(expected_response)
          end
        end

        context 'when human player chooses #Rock and server chooses #Paper' do
          it 'player should win with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('paper')
            expected_response = {
             success: true, message: "Oh!! Server won this time. Don't worry. Better luck next time.", data: { result: 'Server Won', player_move: 'Rock', server_move: 'Paper' }
            }
            expect(RockPaperScissors.new('rock').play).to eq(expected_response)
          end
        end

        context 'when human player chooses #Scissors and server chooses #Rock' do
          it 'player should win with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('rock')
            expected_response = {
             success: true, message: "Oh!! Server won this time. Don't worry. Better luck next time.", data: { result: 'Server Won', player_move: 'Scissors', server_move: 'Rock' }
            }
            expect(RockPaperScissors.new('scissors').play).to eq(expected_response)
          end
        end
      end

      describe 'Tie' do

        context 'when human player chooses #Rock and server chooses #Rock' do
          it 'should be tie with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('rock')
            expected_response = {
             success: true, message: "Oh!!. There is a Tie!!. Try again. All the best.", data: { result: 'Tie', player_move: 'Rock', server_move: 'Rock' }
            }
            expect(RockPaperScissors.new('rock').play).to eq(expected_response)
          end
        end

        context 'when human player chooses #Paper and server chooses #Paper' do
          it 'should be tie with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('paper')
            expected_response = {
             success: true, message: "Oh!!. There is a Tie!!. Try again. All the best.", data: { result: 'Tie', player_move: 'Paper', server_move: 'Paper' }
            }
            expect(RockPaperScissors.new('paper').play).to eq(expected_response)
          end
        end

        context 'when human player chooses #Scissors and server chooses #Scissors' do
          it 'should be tie with success response' do
            allow(ConfigCenter::GAME_CHOICES).to receive(:sample).and_return('scissors')
            expected_response = {
             success: true, message: "Oh!!. There is a Tie!!. Try again. All the best.", data: { result: 'Tie', player_move: 'Scissors', server_move: 'Scissors' }
            }
            expect(RockPaperScissors.new('scissors').play).to eq(expected_response)
          end
        end
      end

      describe 'Invalid choice' do
        context 'when human player chooses an invalid choice' do
          it 'generates failure response' do
            expected_response = {
              success: false, message: 'Invalid choice. Options should be eiether Rock, Paper or Scissors. Please try again', data: nil
            }
            expect(RockPaperScissors.new('invalid').play).to eq(expected_response)
          end
        end
      end
      
    end
  end
end
