require_relative 'player'
require_relative 'board'
require_relative 'ai'

class Game 
  attr_accessor :current_player, :player_1, :player_2, :x, :y, :turn, :board

  $game = true

  ACTIONS = {
    'exit' => lambda { system('clear'); puts "Thanks for playing!"; exit(0)},
    'quit' => lambda { system('clear'); puts "Thanks for playing!"; exit(0)},
    'help' => lambda { puts " 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n\n"}
  }

  def initialize(game_type=1)
    case game_type
    when 1
      p1 = true
      p2 = false
    when 2 
      p1 = true
      p2 = true
    when 3
      p1 = false
      p2 = false
    end
    @player_1 = Player.new('X', p1)
    @player_2 = Player.new('O', p2)
    @board    = Board.new
    @current_player = @player_1
    @board.current_player = @current_player
  end

  def draw(board)
    system('clear')
    board.update
  end

  def get_move(player)
    if player.human
      move = parse_input 
      if @board.move_available?(move)
        @board.player_move(move,player.type)
        draw(@board)
      else
        draw(@board)
        get_move(player)
      end
    else
      sleep(0.5)
      Ai.make_move(@board, player)
      draw(@board)
    end
    if @board.player_win?
      draw(@board)
      $game = false
    else
      switch_player
    end
  end

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
      @board.current_player = @player_2
    else
      @current_player = @player_1
      @board.current_player = @player_1
    end
  end

  def parse_input
    input = Readline.readline("[ #{@current_player.type.upcase} , Its Your Move]: ", true) 
    if ACTIONS[input]
      begin
        draw(board)
        ACTIONS[input].call
        get_move(@current_player)
      rescue StandardError => e
        $stderr.puts e.to_s.red
      end
    else
      input
    end
  end

  # Main Loop
  def start
    while $game do
      winner if @board.player_win?
      draw(@board)
        get_move(@current_player)
      stalemate if @board.available_moves == 0
    end
    winner
  end

  def winner
    draw(@board)
    puts "\n#{@current_player.type} Wins!"
    puts "press enter to quit"
    gets
    system('clear')
    exit(0)
  end

  def stalemate
    draw(@board)
    puts "\nSTALEMATE!"
    puts "press enter to quit"
    gets
    system('clear')
    exit(0)
  end

end

