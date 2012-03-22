require "rubygems"
require "rspec"
require "pry"
require "colored"
require File.expand_path("../../lib/tic_tac_ruby.rb",__FILE__)

module Helpers
  # Replace standard input with faked one StringIO. 
  def fake_stdin(text)
    begin
      $stdin = StringIO.new
      $stdin.puts(text)
      $stdin.rewind
      yield
    ensure
      $stdin = STDIN
    end
  end
end

RSpec.configure do |conf|
  conf.include(Helpers)
end

Rspec.configure do |c|
  c.mock_with :rspec
end
