class Player

  attr_accessor :type, :human
  
  def initialize(type, human=true)
    @type  = type
    @human = human
  end


  def is_x?
    true if @type == 'X'
  end

  def is_y?
    true if @type == "Y"
  end
end
