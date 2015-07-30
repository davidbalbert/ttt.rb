PLAYERS = {
  1 => "X",
  -1 => "O"
}

$player = 1

$board = [0,0,0,0,0,0,0,0,0]

WINNING_MOVES = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def switch_players
  $player *= -1
end

def game_over?
  somebody_won? || no_moves_left?
end

def no_moves_left?
  $board.all? { |x| x != 0 }
end

def somebody_won?
  sums.any? { |sum| sum.abs == 3 }
end

def sums
  WINNING_MOVES.map do |indices|
    $board.values_at(*indices).reduce(:+)
  end
end

def winner
  s = sums.find { |sum| sum.abs == 3}

  s / 3
end

def b(i)
  if $board[i] == 0
    i
  else
    PLAYERS[$board[i]]
  end
end

def board_string
  <<-BOARD
#{b(0)} | #{b(1)} | #{b(2) }
#{b(3)} | #{b(4)} | #{b(5) }
#{b(6)} | #{b(7)} | #{b(8) }
  BOARD
end

def print_board
  puts board_string
end

def print_results
  w = winner

  if w
    puts "#{PLAYERS[w]} won!"
  else
    puts "Tie game"
  end
end

def taken?(move)
  $board[move] != 0
end

def make_move
  print "Make your move (0-8): "
  move = nil

  loop do
    begin
      move = Integer(gets.chomp)
    rescue ArgumentError
      print "You need to enter a number. Make your move: "
      retry
    end

    if !(0..8).include?(move)
      print "#{move} is not between 0 and 8. Make your move: "
    elsif taken?(move)
      print "#{move} has already been taken. Make your move: "
    else
      break
    end
  end

  $board[move] = $player
end

def play
  until game_over?
    print_board
    make_move
    switch_players
  end

  print_results
end

play
