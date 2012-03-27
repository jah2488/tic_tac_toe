module TicTacRuby
  class InputOutput

    attr_accessor :prompt
    attr_reader   :read_source, :write_source

    def initialize(prompt = "> ", read_source = $stdin, write_source = $stdout)
      @prompt       = prompt
      @read_source  = read_source
      @write_source = write_source
    end

    ACTIONS = {
      'exit' => "",
      'quit' => "",
      'help' => ""
    }

    def parse_input(reader = reader)
      input = reader
      case input.downcase
      when "help" 
        help
        parse_input
      when "exit", "quit", "q"
        quit_game
      else
        input
      end
    end

    def reader(input = @read_source)
      pout @prompt.magenta
      input.gets.to_s.chomp
    end

    def out(message, output_source = @write_source)
      output_source.puts message
    end

    def pout(message, output_source = @write_source)
      output_source.print message
    end

    def game_over(message = "GAME OVER")
      out message.green
      loop do
        out "Would you like to play again? (#{'Y'.green})es | (#{'N'.red})o"
        input = parse_input
        case input.downcase
        when "y", "yes"
          Menu.new
        when "n", "no"
          quit_game
        else
          out "Invalid Input. Try again.".red
        end
      end
    end

    def help
      out "\n 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9\n\n"
    end

    def quit_game
      system('clear')
      puts "Thanks for playing!"
      exit(0)
    end

  end
end
