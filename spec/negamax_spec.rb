require 'spec_helper'

describe TicTacRuby::Negamax do
  
  let(:x) do
    'X'
  end
  
  let(:o) do
    'O'
  end

  let(:player) do
    TicTacRuby::Player.new(x, false)
  end

  let(:board) do
    TicTacRuby::Board.new
  end

  let(:negamax) do
    TicTacRuby::Negamax.new
  end

  it "should win against a given move set 2,6,3,9" do
    player.type = o
    board.player_move('2', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.player_move('6', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.player_move('3', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.game_over?.should == true
  end

  it "should win against a given move set 2,6,9,8,7" do
    player.type = o
    board.player_move('2', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.player_move('6', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.player_move('9', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.player_move('8', 'X')
    board.player_move(negamax.make_move(board,player), 'O')
    board.move_available?('7').should == false
  end

  it "should make final winning move as x" do
    board.player_move("1", o)
    board.player_move("2", x)
    board.player_move("3", o)
    board.player_move("4", o)
    board.player_move("5", x)
    board.player_move("6", o)
    board.player_move("7", x)
    negamax.make_move(board,player).should == 8
  end

  it "should make final winning move as o" do
    board.player_move("1", o)
    board.player_move("2", x)
    board.player_move("3", o)
    board.player_move("4", o)
    board.player_move("5", x)
    board.player_move("6", o)
    board.player_move("7", x)
    player.type = o
    negamax.make_move(board,player).should == 9
  end

  it "should make horizontal winning move" do
    board.player_move("1", x)
    board.player_move("2", x)
    board.player_move("4", o)
    negamax.make_move(board,player).should == 3
  end

  it "should make horizontal blocking move" do
    board.player_move("1", o)
    board.player_move("2", o)
    board.player_move("4", x)
    negamax.make_move(board,player).should == 3
  end

  it "should make vertical winning move" do
    board.player_move("1", x)
    board.player_move("2", o)
    board.player_move("3", o)
    board.player_move("4", x)
    board.player_move("5", o)
    board.player_move("6", o)
    negamax.make_move(board,player).should == 7
  end

  it "should make vertical blocking move" do
    board.player_move("1", o)
    board.player_move("4", o)
    board.player_move("9", x)
    negamax.make_move(board,player).should == 7
  end

  it "should win left to right" do
    board.player_move("1", x)
    board.player_move("2", o)
    board.player_move("3", o)
    board.player_move("5", x)
    board.player_move("6", o)
    board.player_move("4", o)
    negamax.make_move(board,player).should == 9
  end

  it "should win right to left" do
    board.player_move("1", o)
    board.player_move("2", o)
    board.player_move("3", x)
    board.player_move("5", x)
    board.player_move("4", o)
    negamax.make_move(board,player).should == 7
  end

  it "should block left to right" do
    board.player_move("1", o)
    board.player_move("2", x)
    board.player_move("3", x)
    board.player_move("5", o)
    board.player_move("4", x)
    negamax.make_move(board,player).should == 9
  end

  it "should block right to left" do
    board.player_move("1", x)
    board.player_move("2", x)
    board.player_move("3", o)
    board.player_move("5", o)
    board.player_move("4", x)
    negamax.make_move(board,player).should == 7
  end


  context ".opponent" do

    it "should set opponent to O when player type is X" do
      opponent = negamax.opponent(player)
      opponent.type.should == 'O'
    end

    it "should set opponent to X when player tyep is O" do
      player.type = 'O'
      opponent = negamax.opponent(player)
      opponent.type.should == 'X'
    end
  end

  context ".check_winner" do

    it "should return 1 if Player x 'Max' is the winner horizontal" do
      board.player_move("1", x)
      board.player_move("2", x)
      board.player_move("3", x)
      negamax.check_winner(board, player).should == 1
    end

    it "should return 1 if Player x 'Max' is the winner vertical" do
      board.player_move("1", x)
      board.player_move("4", x)
      board.player_move("7", x)
      negamax.check_winner(board, player).should == 1
    end

    it "should return 1 if Player 'Max' is the winner left to right" do
      board.player_move("1", x)
      board.player_move("5", x)
      board.player_move("9", x)
      negamax.check_winner(board, player).should == 1
    end
  
   it "should return 1 if Player 'Max' is the winner right to left" do
      board.player_move("3", x)
      board.player_move("5", x)
      board.player_move("7", x)
      negamax.check_winner(board, player).should == 1
    end

    it "should return 1 if Player o 'Max' is the winner horizontal" do
      board.player_move("1", o)
      board.player_move("2", o)
      board.player_move("3", o)
      player.type = o
      negamax.check_winner(board, player).should == 1
    end

    it "should return 1 if Player o 'Max' is the winner vertical" do
      board.player_move("1", o)
      board.player_move("4", o)
      board.player_move("7", o)
      player.type = o
      negamax.check_winner(board, player).should == 1
    end

    it "should return 1 if Player o 'Max' is the winner left to right" do
      board.player_move("1", o)
      board.player_move("5", o)
      board.player_move("9", o)
      player.type = o
      negamax.check_winner(board, player).should == 1
    end

    it "should return 1 if Player o 'Max' is the winner right to left" do
      board.player_move("3", o)
      board.player_move("5", o)
      board.player_move("7", o)
      player.type = o
      negamax.check_winner(board, player).should == 1
    end

    it "should return -1 if Opponent x 'Min' is the winner horizontal" do
      board.player_move("1", x)
      board.player_move("2", x)
      board.player_move("3", x)
      player.type = o
      negamax.check_winner(board, player).should == -1
    end

    it "should return -1 if Opponent x 'Min' is the winner vertical" do
      board.player_move("1", x)
      board.player_move("4", x)
      board.player_move("7", x)
      player.type = o
      negamax.check_winner(board, player).should == -1
    end

    it "should return 1 if Opponent x 'Min' is the winner left to right" do
      board.player_move("1", x)
      board.player_move("5", x)
      board.player_move("9", x)
      player.type = o
      negamax.check_winner(board, player).should == -1
    end

    it "should return 1 if Opponent x 'Min' is the winner left to right" do
      board.player_move("3", x)
      board.player_move("5", x)
      board.player_move("7", x)
      player.type = o
      negamax.check_winner(board, player).should == -1
    end

    it "should return 0 if Stalemate" do
      board.player_move("1", o)
      board.player_move("2", x)
      board.player_move("3", o)
      board.player_move("4", x)
      board.player_move("5", o)
      board.player_move("6", x)
      board.player_move("7", x)
      board.player_move("8", o)
      board.player_move("9", x)
      negamax.check_winner(board, player).should == 0
    end

    it "should return 0 if Stalemate" do
      board.player_move("1", o)
      board.player_move("2", o)
      board.player_move("3", x)
      board.player_move("4", x)
      board.player_move("5", o)
      board.player_move("6", o)
      board.player_move("7", o)
      board.player_move("8", x)
      board.player_move("9", x)
      negamax.check_winner(board, player).should == 0
    end

    it "should return 0 if Stalemate" do
      board.available_moves = 0
      negamax.check_winner(board, player).should == 0
    end

  end
end
