module TicTacRuby
  class Board 

    attr_reader :board, :rows, :cols, :cells
    attr_accessor :available_moves, :current_player

    def initialize(board = nil)
      @rows  = 3
      @cols  = 3
      @cells = 9
      @available_moves = 9
      @board = [
               [' ',' ',' '],#0
               [' ',' ',' '],#1
               [' ',' ',' '],#2 
               ]
      @board = board if board
    end

    def player_move(move, type)
      set_cell_value(move, type)
      available_moves
    end

    def available_moves
      @available_moves = 0
      3.times do |row|
        @board[row].collect do |cell|
          @available_moves += 1 if cell == " " 
        end
      end
      return @available_moves
    end


    def move_available?(move)
     false if move =~ /[a-zA-Z]/
     cell = get_cell_value(move)
     if cell =~ /\s/
       return true
     else
       return false
     end
    end

    def get_cell_value(pos)
      case pos.to_s
      when "1", "[0, 0]" then @board[0][0]
      when "2", "[0, 1]" then @board[0][1]
      when "3", "[0, 2]" then @board[0][2]
      when "4", "[1, 0]" then @board[1][0]
      when "5", "[1, 1]" then @board[1][1]
      when "6", "[1, 2]" then @board[1][2]
      when "7", "[2, 0]" then @board[2][0]
      when "8", "[2, 1]" then @board[2][1]
      when "9", "[2, 2]" then @board[2][2]
      end
    end

    def set_cell_value(pos, val)
      case pos.to_s
      when "1", "[0, 0]" then @board[0][0] = val
      when "2", "[0, 1]" then @board[0][1] = val
      when "3", "[0, 2]" then @board[0][2] = val
      when "4", "[1, 0]" then @board[1][0] = val
      when "5", "[1, 1]" then @board[1][1] = val
      when "6", "[1, 2]" then @board[1][2] = val
      when "7", "[2, 0]" then @board[2][0] = val
      when "8", "[2, 1]" then @board[2][1] = val
      when "9", "[2, 2]" then @board[2][2] = val
      end
    end

    def game_over?
      if player_win?('X') || player_win?('O') || @available_moves < 1
        true
      else
        false
      end
    end

    def player_win?(player)
      results = []
      results << horizontal_score?(player)
      results << vertical_score?(player)
      results << left_to_right_angle_score?(player)
      results << right_to_left_angle_score?(player)
      if results.include?(true)
        return true
      else
        return false
      end
    end

    def horizontal_score?(player)
      val = []
      result = false
      3.times do |i|
        val = @board[i]
        result = check_row(val, player)
        break if result
      end
      return result
    end

    def vertical_score?(player)
      result = false
      3.times do |i|
        val = []
        3.times do |j|
          val << @board[j][i]
        end
        result = check_row(val, player)
        break if result
      end
      return result
    end
    
    def left_to_right_angle_score?(player)
      val = []
      3.times do |i|
        val << @board[i][i]
      end
      return result = check_row(val, player)
    end
    
    def right_to_left_angle_score?(player)
      val = []
      3.times do |i|
        val << @board[2-i][i]
      end
      return result = check_row(val, player)
    end

    def check_row(val, player)
      result = false
      val = val.collect { |n| n == player }
      if val.uniq.to_s == "[true]"
        result = true
      else
        result = false
      end
      return result
    end

    def update
      puts ""
      @board.each_with_index do |row, i|
        row_print = row.collect{ |s| s }.join(" | ")
        puts row_print
        row_trim = "-" * row_print.length
        puts row_trim if @board.length != (i + 1)
      end
      puts ""
    end

  end
end