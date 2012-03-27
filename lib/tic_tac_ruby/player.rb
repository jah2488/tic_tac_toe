module TicTacRuby
  class Player

    attr_accessor :type, :human

    def initialize(type, human=true)
      @type  = type
      @human = human
    end

  end
end
