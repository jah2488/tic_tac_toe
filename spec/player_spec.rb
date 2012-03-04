require 'spec_helper'

describe Player do
  context "Player 1 is X and is human" do
    let(:player) do
      Player.new('X', true)
    end
    it "should know its x" do
      player.type.should == 'X'
    end
    it "should know its human" do
      player.human.should equal true
    end
  end
end
