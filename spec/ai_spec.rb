require 'spec_helper'

describe Ai do

  let(:player_x) do
    Player.new('X',false)
  end
  let(:player_o) do
    Player.new('O',false)
  end
  let(:board) do
    Board.new
  end

  context "Should know the rules" do

    context "Rule 1: Take any open winning move first" do

      it "should take all winning moves horizontally" do
        board.player_move('1','O')
        board.player_move('2','O')
        Ai.make_move(board,player_o)
        board.board[0][2].should == 'O'
      end
      
      it "should take all winning moves vertically" do
        board.player_move('1','O')
        board.player_move('4','O')
        Ai.make_move(board,player_o)
        board.board[2][0].should == 'O'
      end
      
      it "... even upsidedown" do
        board.player_move('8', 'O')
        board.player_move('5', 'O')
        Ai.make_move(board,player_o)
        board.board[0][1].should == 'O'
      end

      it "should take all winning moves left-to-right" do
        board.player_move('1','X')
        board.player_move('5','X')
        Ai.make_move(board,player_x)
        board.board[2][2].should == 'X'
      end

      it "should take all winning moves right-to-left" do
        board.player_move('3','O')
        board.player_move('5','O')
        Ai.make_move(board,player_o)
        board.board[2][0].should == 'O'
      end

      it "should take winning move even if other moves are open horizontally" do
        board.player_move('1','X')
        board.player_move('2','X')
        board.player_move('4','O')
        board.player_move('5','O')
        Ai.make_move(board,player_o)
        board.board[1][2].should == 'O'
      end

      it "should take winning move even if other moves are open vertically" do
        board.player_move('1','X')
        board.player_move('4','X')
        board.player_move('2','O')
        board.player_move('5','O')
        Ai.make_move(board,player_o)
        board.board[2][1].should == 'O'
      end
    end

    context "Rule 2: Block Opponent from winning" do

      it "should block player horizontally" do
        board.player_move('1','X')
        board.player_move('2','X')
        Ai.make_move(board,player_o)
        board.board[0][2].should == 'O'
      end

      it "should block player vertically" do
        board.player_move('1','X')
        board.player_move('4','X')
        Ai.make_move(board,player_o)
        board.board[2][0].should == 'O'
      end

      it "should block player left-to-right" do
        board.player_move('1','X')
        board.player_move('5','X')
        Ai.make_move(board,player_o)
        board.board[2][2].should == 'O'
      end

      it "should block player right-to-left" do
        board.player_move('3','X')
        board.player_move('5','X')
        Ai.make_move(board,player_o)
        board.board[2][0].should == 'O'
      end
    end

    context "Rule 3: Play the center" do
      it "should go to center if board is open" do
        Ai.make_move(board,player_x)
        board.board[1][1].should == 'X'
      end
    end
    
    context "Rule 4: Play the opposite corner of the player" do
      it "should go to opposite corner of other player" do
        board.player_move('1','X')
        board.player_move('5','X')
        Ai.make_move(board,player_o)
        board.board[2][2].should == 'O'
      end
    
      it "should go to opposite corner of other player" do
        board.player_move('9','X')
        board.player_move('5','X')
        Ai.make_move(board,player_o)
        board.board[0][0].should == 'O'
      end
    end

    

    
  end

end