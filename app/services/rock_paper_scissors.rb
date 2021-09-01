class RockPaperScissors
	attr_accessor :player_choice, :server_choice, :result

	def initialize(player_choice)
		@player_choice = player_choice
		@server_choice = @result = ''
	end

	def play
		if is_valid_choice?(player_choice)
			@server_choice = ConfigCenter::GAME_CHOICES.sample
			@result = play_game([player_choice, server_choice])
			{ success: true, messages: compute_message, data: { result: @result, player_move: player_choice, server_move: server_choice } }
		else
			{success: false, messages: ['Invalid choice. Options should be eiether Rock, Paper or Scissors. Please try again'], data: { player_move: player_choice } }
		end
	end

	private

	def play_game(move)
		return ConfigCenter::PLAYER_WON if ConfigCenter::WINNER.include?(move)
		return ConfigCenter::SERVER_WON if ConfigCenter::LOOSER.include?(move)
		ConfigCenter::TIE
	end

	def is_valid_choice?(player_choice)
		ConfigCenter::GAME_CHOICES.include?(@player_choice.to_s)
	end

	def compute_message
		case @result
		when ConfigCenter::PLAYER_WON
			'Wow!! You Won. Congratulations.'
		when ConfigCenter::SERVER_WON
			"Oh!! Server won this time. Don't worry. Better luck next time."
		else
			"Oh!!. There is a Tie!!. Try again. All the best."
		end
	end

end
