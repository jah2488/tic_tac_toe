require 'rubygems'
require 'shellwords'
require 'pry'
require 'readline'
require 'colored'
require_relative 'game'
require_relative 'menu'
require_relative 'player'
require_relative 'board'
require_relative 'ai'

class Engine

  ACTIONS = {
    'exit' => lambda { |code = 0| exit(code.to_i) },
    'help' => lambda { puts " 1 | 2 | 3\n-----------\n 4 | 5 | 6\n-----------\n 7 | 8 | 9"}
    }

  def parse_input
    input = Readline.readline("~> ", true) 
    command, *args = Shellwords.shellsplit(input)
    if ACTIONS[command]
      begin
        ACTIONS[command].call

      rescue StandardError => e

        $stderr.puts e.to_s.red

      end
    else
      input
    end
  end
end