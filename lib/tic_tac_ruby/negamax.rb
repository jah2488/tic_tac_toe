module TicTacRuby
  class Negamax

    def make_move(board, player)
      negamax(board, player, 1)
      return @best_move
    end

    def opponent(player)
      player.type === 'O' ? opponent = Player.new('X') : opponent = Player.new('O')
      return opponent
    end

    def check_winner(board, player)
      opponent = opponent(player)
      if board.player_win?(player.type)
        return 1
      elsif board.player_win?(opponent.type)
        return -1
      else
        return 0
      end
    end

    def negamax(board, player, depth)
      if board.available_moves >= 8
        #Skip running negamax on first move and instead pick one of the best "starting moves"
        [5,1,3,7,9].reverse.map { |move| @best_move = move if board.move_available?("#{move}") }
      else
        if board.game_over?
          return check_winner(board, player)
        else
          best_rank = -999
          opponent = opponent(player)

          (1..board.cells).each do |cell|
            if board.move_available?("#{cell}")
              current_board = Board.new( Marshal.load(Marshal.dump(board.board)) ) #marshal the board to ensure a deep copy
              current_board.player_move("#{cell}", player.type)
              rank = -negamax(current_board, opponent, depth + 1)
              if rank > best_rank
                best_rank = rank
                @best_move = cell if depth == 1
              end
            end
          end
          return best_rank
        end
      end
    end
  
  end
end
