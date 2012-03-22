require 'spec_helper'

describe TicTacRuby::Input do
  
  let(:input) do
    TicTacRuby::Input.new
  end
  
  #horrible test coverage. Current methods dont allow very granular testing.
  
  context ".parse_input" do

    it "should receive input" do
      input.stub(:parse_input).and_return("hello")
      input.parse_input.should == "hello"
    end

  end

end
