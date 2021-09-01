module ConfigCenter
  GAME_CHOICES = ['paper', 'rock','scissors'].freeze

  # Pairs representing winner. The first entry in each pair represent Human Player and second one Server move
  WINNER = [
    [GAME_CHOICES[2], GAME_CHOICES[0]],
    [GAME_CHOICES[0], GAME_CHOICES[1]],
    [GAME_CHOICES[1], GAME_CHOICES[2]]
  ]

  # Pairs representing looser. The first entry in each pair represent server move and second one human player move
  LOOSER = WINNER.map { |option_1, option_2| [option_2, option_1] }

  PLAYER_WON = 'player-won'
  SERVER_WON = 'server-won'
  TIE = 'tie'

end
