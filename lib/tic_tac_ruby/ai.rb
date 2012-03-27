module TicTacRuby
  class Ai

    attr_accessor :rank_board, :play_board, :type, :rows, :cols, :ltr, :rtl

    def self.make_move(board, player)
      @play_board = board.board
      @types      = ["X","O"]
      @type       = player.type
      @opponent   = (@type == @types[0]) ? @types[1] : @types[0]
      @rank_board = [[4,3,4], #default placement priority
                     [3,5,3],
                     [4,3,4]]
      @cols  = []
      @rows  = []
      @ltr   = []
      @rtl   = []
      return rank_tiles
    end

    private

    def self.rank_tiles
      add_existing_moves
      check_win_or_block(@type,100) #win
      check_win_or_block(@opponent, 50) #block
      react_to_player
      return pick_move
    end

    def self.add_existing_moves
      3.times do |row|
        3.times do |col|
          @rank_board[row][col] = 0 if @play_board[row][col] != " "
        end
        @rows << @play_board[row]
        @ltr  << @play_board[row][row]
        @rtl  << @play_board[2-row][row]
      end
      @cols = @rows.transpose
    end

    def self.pick_move
      max = @rank_board.flatten.sort.last
      move = []
      @rank_board.each do |row|
        if row.index(max)
          move << @rank_board.index(row)
          move << row.index(max)
        end
      end
      if move.length > 2 #if more than one option present
        move = move[0..1]
        # moves = []
        # move.each_slice(2) {|n| moves << n}
        # move = moves.shuffle.first #shuffle and pick first cell
      end
      return move
    end

    def self.react_to_player #Add points to corners or sides depending on player
      if @play_board[0][0] == @opponent and @play_board[2][2] == " "
        @rank_board[2][2] += 1
      elsif @play_board[0][2] == @opponent and @play_board[2][0] == " "
        @rank_board[2][0] += 1
      elsif @play_board[2][0] == @opponent and @play_board[0][2] == " "
        @rank_board[0][2] += 1
      elsif  @play_board[2][2] == @opponent and @play_board[0][0] == " "
        @rank_board[0][0] += 1
      end
      if @play_board[0][0] == @opponent and @play_board[2][0] == @opponent and @play_board[1][0] == " "
        @rank_board[1][0] += 50
      elsif @play_board[2][0] == @opponent and @play_board[2][2] == @opponent and @play_board[2][1] == " "
        @rank_board[2][1] += 50
      elsif @play_board[2][2] == @opponent and @play_board[0][2] == @opponent and @play_board[1][2] == " "
        @rank_board[1][2] += 50
      elsif @play_board[0][0] == @opponent and @play_board[0][2] == @opponent and @play_board[0][1] == " "
        @rank_board[0][1] += 50
      end
    end

    def self.check_win_or_block(type, amount)
      update_rows(type,amount)
      update_cols(type,amount)
      result = @ltr.select { |cell| cell.include? type }
      if result.length == 2
        3.times do |i|
          @rank_board[i][i] += amount if @rank_board[i][i] > 0
        end
      end
      result = @rtl.select {|cell| cell.include? type }
      if result.length == 2
        3.times do |i|
          @rank_board[2-i][i] += amount if @rank_board[2-i][i] > 0
        end
      end
    end

    def self.update_rows(type, amount)
      3.times do |i|
        result = @rows[i].select { |cell| cell.include? type}
        if result.length == 2
          @rank_board[i].collect! do |cell|
            if cell > 0
              cell += amount
            else
              cell
            end
          end
        end
      end
    end
    
    def self.update_cols(type, amount)
      3.times do |i|
        result = @cols[i].select { |cell| cell.include? type}
        if result.length == 2
          cels = [@rank_board[0][i],@rank_board[1][i],@rank_board[2][i] ]
          cels.collect! do |cell|
            if cell > 0 #is_empty?
              cell += amount
            else
              cell
            end
          end
          @rank_board[0][i],@rank_board[1][i],@rank_board[2][i] = cels[0], cels[1], cels[2]
        end
      end
    end

  end
end
