require_relative 'player'
require_relative 'input'
require_relative 'board'
require_relative 'ai'

class Game 
  attr_accessor :current_player, :player_1, :player_2, :x, :y, :turn, :board, :game

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
    @game  = true
    @input = Input.new
  end

  def draw
    system('clear')
    @board.update
    print "[ #{@current_player.type.upcase} , Its Your Move]"
  end

  def get_move(player)
    if player.human
      move = @input.parse_input 
      if @board.move_available?(move)
        @board.player_move(move,player.type)
      else
        puts "Not An Available".red
        get_move(player)
      end
    else
      sleep(0.5) unless @player_1.human #slow things down while watching the Ai vs Ai
      Ai.make_move(@board, player)
    end

    if @board.player_win?
      @game = false
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

  # Main Loop
  def start
    while @game do
      winner if @board.player_win?
      draw
      get_move(@current_player)
      stalemate if @board.available_moves == 0
    end
    winner
  end

  def winner
    draw
    puts "\n#{@current_player.type} Wins!".magenta
    puts "Would you like to play again? (Y)es | (N)o"
    @input.game_over
  end

  def stalemate
    draw
    puts "\nSTALEMATE!".green
    puts "Would you like to play again? (Y)es | (N)o"
    @input.game_over
  end

end

