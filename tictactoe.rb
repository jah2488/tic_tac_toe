#!/usr/bin/env ruby
require 'rubygems'
require 'pry'
require 'readline'
require 'colored'
require_relative 'lib/game'
require_relative 'lib/menu'


class Tictactoe
  def initialize
    Menu.new
  end
end

Tictactoe.new