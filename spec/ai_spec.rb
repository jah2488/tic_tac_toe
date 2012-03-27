require 'spec_helper'

describe TicTacRuby::Ai do

  let(:ai) do
    TicTacRuby::Ai
  end
  let(:player_x) do
    TicTacRuby::Player.new('X',false)
  end
  let(:player_o) do
    TicTacRuby::Player.new('O',false)
  end
  let(:board) do
    TicTacRuby::Board.new
  end

  context "Should know the rules" do

    context "Rule 1: Take any open winning move first" do

      it "should take all winning moves horizontally" do
        board.player_move('1','O')
        board.player_move('2','O')
        ai.make_move(board,player_o).should == [0, 2]
      end
      
      it "should take all winning moves vertically" do
        board.player_move('1','O')
        board.player_move('4','O')
        ai.make_move(board,player_o).should == [2, 0]
      end
      
      it "... even upsidedown" do
        board.player_move('8', 'O')
        board.player_move('5', 'O')
        ai.make_move(board,player_o).should == [0, 1]
      end

      it "should take all winning moves left-to-right" do
        board.player_move('1','X')
        board.player_move('5','X')
        ai.make_move(board,player_x).should == [2, 2]
      end

      it "should take all winning moves right-to-left" do
        board.player_move('3','O')
        board.player_move('5','O')
        ai.make_move(board,player_o).should == [2, 0]
      end

      it "should take winning move even if other moves are open horizontally" do
        board.player_move('1','X')
        board.player_move('2','X')
        board.player_move('4','O')
        board.player_move('5','O')
        ai.make_move(board,player_o).should == [1, 2]
      end

      it "should take winning move even if other moves are open vertically" do
        board.player_move('1','X')
        board.player_move('4','X')
        board.player_move('2','O')
        board.player_move('5','O')
        ai.make_move(board,player_o).should == [2, 1]
      end
    end

    context "Rule 2: Block Opponent from winning" do

      it "should block player horizontally" do
        board.player_move('1','X')
        board.player_move('2','X')
        ai.make_move(board,player_o).should == [0,2]
      end

      it "should block player vertically" do
        board.player_move('1','X')
        board.player_move('4','X')
        ai.make_move(board,player_o).should == [2, 0]
      end

      it "should block player left-to-right" do
        board.player_move('1','X')
        board.player_move('5','X')
        ai.make_move(board,player_o).should == [2, 2]
      end

      it "should block player right-to-left" do
        board.player_move('3','X')
        board.player_move('5','X')
        ai.make_move(board,player_o).should == [2, 0]
      end
    end

    context "Rule 3: Play the center" do
      it "should go to center if board is open" do
        ai.make_move(board,player_x).should == [1, 1]
      end
    end
    
    context "Rule 4: Play the opposite corner of the player" do
      it "should go to opposite corner of other player" do
        board.player_move('1','X')
        board.player_move('5','X')
        ai.make_move(board,player_o).should == [2, 2]
      end
    
      it "should go to opposite corner of other player" do
        board.player_move('9','X')
        board.player_move('5','X')
        ai.make_move(board,player_o).should == [0, 0]
      end
    end
  end

  context "when given a set of moves" do
    it "should not be beaten by 2,6,3,9" do
      board.player_move('2', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.player_move('6', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.player_move('3', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.move_available?('9').should == false
    end
    it "should not be beaten by 6,8,9,7" do
      board.player_move('6', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.player_move('8', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.player_move('9', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.move_available?('7').should == false
    end
    it "should not be beaten by 8,4,7,1" do
      board.player_move('8', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.player_move('4', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.player_move('7', 'X')
      board.player_move(ai.make_move(board,player_o), 'O')
      board.move_available?('1').should == false
    end
  end

end
