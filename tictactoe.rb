#!/usr/bin/env ruby

require_relative 'lib/menu'

class Tictactoe

  def initialize
    Menu.new
  end
end

Tictactoe.new