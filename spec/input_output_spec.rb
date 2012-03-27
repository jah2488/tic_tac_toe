require 'spec_helper'
require 'stringio'
describe TicTacRuby::InputOutput do

  let(:input) do
    input  = StringIO.new
  end

  let(:output) do
    output = StringIO.new
  end
  
  let(:io) do
    TicTacRuby::InputOutput.new("",input,output)
  end

  context ".reader" do
    it "should recieve input" do
      read('hello').should == "hello"
    end
  end

  context ".parse_input" do

    it "should receive input" do
      io.parse_input("1").should == "1"
    end

    it "should call help command" do
      io.should_receive(:help)
      io.parse_input("help")
    end

    it "should exit with command" do
      lambda { io.parse_input("exit") }.should raise_error SystemExit
    end

    it "should quit with command" do
      lambda { io.parse_input("quit") }.should raise_error SystemExit
    end
  end

  context ".help" do
    it "should print help board to screen using .out" do
      io.help
      output.rewind
      output.read.should match "\n 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n\n"
    end
  end

  context ".quit_game" do
    it "should exit the game" do
      lambda { io.quit_game }.should raise_error SystemExit
    end
  end
  
  context ".game_over" do

    it "should start a new game if yes" do
      #Test passes, but if you explicitely break it, you can see the lambda isn't returning the should
      #statement and thus test or method should be refactored.
      lambda { TicTacRuby::Menu.should_receive(:new); input.write("y"); input.rewind; io.game_over }
    end
    
    it "should quit if player answers no" do
      lambda { input.write("n"); input.rewind; io.game_over }.should raise_error SystemExit
    end
  
  end
  
  context ".out" do

    it "should 'puts' messages given to it" do
      io.out("hi")
      output.rewind
      output.read.should == "hi\n"
    end

    it "should not be empty when given a string" do
      io.out("hi")
      output.rewind
      output.read.should_not == ""
    end
  end

  context ".pout" do

    it "prints messages given to it" do
      io.pout("hi")
      output.rewind
      output.read.should == "hi"
    end

    it "should not be empty when given a string" do
      io.pout("hi")
      output.rewind
      output.read.should_not == ""
    end
  end
end
