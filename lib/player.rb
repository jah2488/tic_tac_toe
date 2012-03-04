class Player

  attr_accessor :type, :human, :color

  def initialize(type,human=true, color="green")
    @type  = type
    @human = human
    @color = color
  end


  def is_x?
    true if @type == 'X'
  end
end
