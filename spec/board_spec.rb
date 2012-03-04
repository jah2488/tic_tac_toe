require 'spec_helper'

describe Board do

  context "should validate win conditions accurately" do

    let(:player1) do
      Player.new("X",true)
    end
    let(:player2) do
      Player.new("O",true)
    end
    let(:board) do
      Board.new
    end
    before(:each) do
      board.current_player = player1
    end

    it "should allow player X to win horizontally" do
      3.times do |i|
        board.board[i] = ["X","X","X"]
        board.player_win?.should == true
      end
    end

    it "should allow player O to win horizontally" do
      board.current_player = player2
      3.times do |i|
        board.board[i] = ["O"]
        board.player_win?.should == true
      end
    end

    it "should allow O to win in middle col" do
      board.current_player = player2
      board.player_move('2','O')
      board.player_move('5','O')
      board.player_move('8','O')
      board.player_win?.should == true
    end

    it "should allow player X to win vertically" do
      3.times do |i|
        3.times do |j|
          board.board[j][i] = board.current_player.type
        end
        board.player_win?.should == true
      end
    end

    it "should allow player O to win vertically" do
      board.current_player = player2
      3.times do |i|
        3.times do |j|
          board.board[j][i] = board.current_player.type
        end
        board.player_win?.should == true
      end
    end

    it "Should allow current player to score angled-ly left to right" do
      3.times do |i|
        board.board[i][i] = board.current_player.type
      end
        board.player_win?.should == true
    end

    it "should allow current player to score other angledly" do
      3.times do |i|
        board.board[2-i][i] = board.current_player.type
      end
        board.player_win?.should == true
    end

  end
end
