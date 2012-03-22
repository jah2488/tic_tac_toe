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

  it "should make winning move" do
    board.current_player = player
    board.player_move("1", x)
    board.player_move("2", x)
    board.player_move("4", o)
    negamax.make_move(board,player).should == 3
  end

  it "should make blocking move" do
    board.current_player = player
    board.player_move("1", o)
    board.player_move("2", o)
    board.player_move("4", x)
    negamax.make_move(board,player).should == 3
  end

  it "should win left to right" do
    board.current_player = player
    board.player_move("1", x)
    board.player_move("5", x)
    board.player_move("4", o)
    negamax.make_move(board,player).should == 9
  end

  it "should win right to left" do
    board.current_player = player
    board.player_move("3", x)
    board.player_move("5", x)
    board.player_move("4", o)
    negamax.make_move(board,player).should == 7
  end

  it "should block left to right" do
    board.current_player = player
    board.player_move("1", o)
    board.player_move("5", o)
    board.player_move("4", x)
    negamax.make_move(board,player).should == 9
  end

  it "should block right to left" do
    board.current_player = player
    board.player_move("3", o)
    board.player_move("5", o)
    board.player_move("4", x)
    negamax.make_move(board,player).should == 7
  end


  context ".opponent" do

    it "should set opponent to O when player type is X" do
    end

    it "should set opponent to X when player tyep is O" do
    end
  end

  context ".check_winner" do

    it "should return 1 if Player 'Max' is the winner" do
    end

    it "should return -1 if Opponent 'Min' is the winner" do
    end
  end

end