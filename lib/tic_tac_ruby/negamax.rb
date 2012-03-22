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
      board.current_player = player
      if board.player_win?
        return 1
      else
        return -1
      end
    end

    def negamax(board, player, depth)
      board.current_player = player
      if board.game_over?
        return check_winner(board, player)
      else
        best_rank = -999
        opponent = opponent(player)
        board.cells.times do |cell|
          current_board = Board.new(board.board)
          if current_board.move_available?("#{cell}")
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
