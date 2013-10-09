require 'gosu'
require './zorder'

class Star
  attr_reader :x, :y
  
  @@animation = nil

  def initialize(window)
    init_animation(window)
    @color = Gosu::Color.new(0xff000000)
    @color.red = rand(40..256)
    @color.green = rand(40..256)
    @color.blue = rand(40..256)
    @x = rand(0..640)
    @y = rand(0..480)
  end
  
  def init_animation(window)
    @@animation = Gosu::Image::load_tiles(window, "media/Star.png", 25, 25, false) unless @@animation
  end

  def draw
    img = @@animation[Gosu::milliseconds / 100 % @@animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0,
        ZOrder::Stars, 1, 1, @color, :add)
  end
end