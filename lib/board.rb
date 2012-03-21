class Board 
  
  attr_accessor :board, :rows, :cols, :available_moves, :current_player

  def initialize
    @rows  = 9
    @cols  = 9
    @board = []
    @available_moves = 9
    build_board(@rows, @cols)
  end

  def build_board(rows,cols)
    @board = [
             [' ',' ',' '],#0
             [' ',' ',' '],#1
             [' ',' ',' '],#2 
             ]
  end

  def player_move(move, type)
    set_cell_value(move, type)
    @available_moves -= 1
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
    case pos
    when "1", [0,0] then @board[0][0]
    when "2", [0,1] then @board[0][1]
    when "3", [0,2] then @board[0][2]
    when "4", [1,0] then @board[1][0]
    when "5", [1,1] then @board[1][1]
    when "6", [1,2] then @board[1][2]
    when "7", [2,0] then @board[2][0]
    when "8", [2,1] then @board[2][1]
    when "9", [2,2] then @board[2][2]
    end
  end

  def set_cell_value(pos, val = nil)
    case pos
    when "1", [0,0] then @board[0][0] = val if val
    when "2", [0,1] then @board[0][1] = val if val
    when "3", [0,2] then @board[0][2] = val if val
    when "4", [1,0] then @board[1][0] = val if val
    when "5", [1,1] then @board[1][1] = val if val
    when "6", [1,2] then @board[1][2] = val if val
    when "7", [2,0] then @board[2][0] = val if val
    when "8", [2,1] then @board[2][1] = val if val
    when "9", [2,2] then @board[2][2] = val if val
    end
  end

  def player_win?
    results = []
    results << horizontal_score?
    results << vertical_score?
    results << left_to_right_angle_score?
    results << right_to_left_angle_score?
    if results.include?(true)
      return true
    else
      return false
    end
  end

  def horizontal_score?
    val = []
    result = false
    3.times do |i|
      val = @board[i]
      result = check_row(val)
      break if result
    end
    return result
  end
  def vertical_score?
    result = false
    3.times do |i|
      val = []
      3.times do |j|
        val << @board[j][i]
      end
      result = check_row(val)
      break if result
    end
    return result
  end
  def left_to_right_angle_score?
    val = []
    3.times do |i|
      val << @board[i][i]
    end
    return result = check_row(val)
  end
  def right_to_left_angle_score?
    val = []
    3.times do |i|
      val << @board[2-i][i]
    end
    return result = check_row(val)
  end

  def check_row(val)
    result = false
    val = val.collect { |n| n == @current_player.type }
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
