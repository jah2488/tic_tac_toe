module TicTacRuby
  class Game 
    attr_accessor :current_player, :player_1, :player_2, :x, :y, :turn, :board, :game, :cpu

    def initialize(game_type=1)
      case game_type
      when 1 # 1 player - 'mark-sweep-zero-depth-rank-heuristic'
        p1 = true
        p2 = false
        @cpu = Ai
      when 2 # 2 player
        p1 = true
        p2 = true
      when 3 # 0 player
        p1 = false
        p2 = false
        @cpu = Ai
      when 4 # 1 player - negamax
        p1 = true
        p2 = false
        @cpu = Negamax.new
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
      print "[ #{@current_player.type.upcase} , Its Your Move. (Type 'help')]"
    end

    def get_move(player)
      if player.human
        move = @input.parse_input 
        if @board.move_available?(move)
          @board.player_move(move, player.type)
        else
          puts "Invalid Move".red
          get_move(player)
        end
      else
        delay
        move = @cpu.make_move(@board, player)
        @board.player_move(move, player.type) if @board.move_available?(move)
      end

      if @board.game_over?
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
        winner if @board.player_win?(@current_player)
        draw
        get_move(@current_player)
        stalemate if @board.available_moves == 0
      end
      winner
    end

    def delay
      sleep(0.5) unless player_2.human
    end

    def winner
      draw
      puts "\n#{@current_player.type} Wins!".magenta
      @input.game_over
    end

    def stalemate
      draw
      puts "\nSTALEMATE!".green
      @input.game_over
    end

  end
end
