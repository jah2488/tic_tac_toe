require "rubygems"
require 'bundler/setup'
Bundler.require(:default)
SimpleCov.start
require File.expand_path("../../lib/tic_tac_ruby.rb",__FILE__)

module Helpers
  def read(string = "hi")
    input = StringIO.new string
    io = TicTacRuby::InputOutput.new
    io.reader(input)
  end
end

RSpec.configure do |conf|
  conf.include(Helpers)
end

RSpec.configure do |c|
  c.mock_with :rspec
end
