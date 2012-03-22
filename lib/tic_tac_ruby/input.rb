module TicTacRuby
  class Input
    attr_reader :input


    ACTIONS = {
      'exit' => lambda { system('clear'); puts "Thanks for playing!"; exit(0)},
      'quit' => lambda { system('clear'); puts "Thanks for playing!"; exit(0)},
      'help' => lambda { puts "\n 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n\n"; puts "press enter to continue";gets}
    }

    def initialize(input = STDIN)
      @input = input
    end

    def parse_input
      input = Readline.readline(": ", true) 
      if ACTIONS[input]
        begin
          ACTIONS[input].call
        rescue StandardError => e
          $stderr.puts e.to_s.red
        end
      else
        input
      end
    end

    def game_over
      loop do
        input = Readline.readline("> ", true)
        case input.downcase
        when "y", "yes" then Menu.new
        when "n", "no"
          system('clear')
          exit(0)
        else
          puts "Invalid Input. Try again.".red
        end
      end
    end
  
  end
end