module TicTacRuby
  class Game
    attr_accessor :current_player, :player_1, :player_2, :board, :cpu

    def initialize(game_type=1)
      case game_type
      when 1 # 1 player - negamax
        p1 = true
        p2 = false
        @cpu = Negamax.new
      when 2 # 2 player
        p1 = true
        p2 = true
      when 3 # 0 player
        p1 = false
        p2 = false
        @cpu = Ai
      when 4 # 1 player
        p1 = true
        p2 = false
        @cpu = Ai
      else
        raise "Illegal Game Type"
      end
      @player_1 = Player.new('X', p1)
      @player_2 = Player.new('O', p2)
      @board    = Board.new
      @current_player = @player_1
      @board.current_player = @current_player
      @io = InputOutput.new(": ")
    end

    def draw
      system('clear')
      @board.update
    end

    def get_move(player)
      @io.pout "[ #{@current_player.type.upcase} , Its Your Move. (Type 'help')]"
      move = @io.parse_input
      if @board.move_available?(move)
        @board.player_move(move, player.type)
      else
        @io.out "Move not available".red
        get_move(player)
      end
    end

    def cpu_move(player)
      @io.pout "[ #{@current_player.type.upcase} , Is contemplating their move...]"
      delay
      move = @cpu.make_move(@board, player)
      @board.player_move(move, player.type) if @board.move_available?(move)
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
      loop do
        draw
        @current_player.human ? get_move(@current_player) : cpu_move(@current_player)
        game_over if @board.game_over?
        switch_player
      end
    end

    def game_over
      @board.player_win?(@current_player.type) ? winner : stalemate
    end

    def delay
      sleep(0.5) unless player_2.human
    end

    def winner
      draw
      @io.game_over("\n#{@current_player.type} Wins!")
    end

    def stalemate
      draw
      @io.game_over("\nSTALEMATE!")
    end

  end
end
