require 'spec_helper'

describe Game do
 
  let(:game1) do
    Game.new(1)
  end
  let(:game2) do
    Game.new(2)
  end
  let(:game3) do
    Game.new(3)
  end

  context "Initializes game types properly." do

    context "When Game Type 1 is selected" do
      
      it "Should set the game with player 1 to human" do
        game1.player_1.human.should equal true
      end

      it "Should set the game with player 2 to not human" do
        game1.player_2.human.should equal false
      end

    end

    context "When Game Type 2 is selected" do
      
      it "Should set the game with player 1 to human" do
        game2.player_1.human.should equal true
      end

      it "Should set the game with player 2 to  human" do
        game2.player_2.human.should equal true
      end

    end

    context "When Game Type 1 is selected" do
      
      it "Should set the game with player 1 to not human" do
        game3.player_1.human.should equal false
      end

      it "Should set the game with player 2 to not human" do
        game3.player_2.human.should equal false
      end

    end

    context ".switch_player" do

      it "should switch current player to player2 when 1" do
        game1.switch_player
        game1.current_player.should == game1.player_2
      end
      it "should switch current player to p1 when p2" do
        game1.current_player = game1.player_2
        game1.switch_player
        game1.current_player.should == game1.player_1
      end
    end
  end
end
