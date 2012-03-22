require 'spec_helper'

describe TicTacRuby::Player do
  
  let(:player) do
    TicTacRuby::Player.new('X', true)
  end

  context "Player 1 is X and is human" do

    it "should know its x" do
      player.type.should == 'X'
    end
    it "should know its human" do
      player.human.should equal true
    end
  end

end
