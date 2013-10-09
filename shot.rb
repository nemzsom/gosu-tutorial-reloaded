require 'gosu'
require './zorder'

class Shot

  @@sound = nil
  
  def initialize(window, x, y, angle)
    @window = window
    @x = x
    @y = y
    @angle = angle
    init_sound
    @@sound.play
  end
  
  def draw
    c = Gosu::Color::WHITE
    x2 = @x + Gosu::offset_x(@angle, 10)
    y2 = @y + Gosu::offset_y(@angle, 10)
    @window.draw_line(@x, @y, c, x2, y2, c, z = ZOrder::Shot)
  end
  
  def move(stars, player)
    @x += Gosu::offset_x(@angle, 15)
    @y += Gosu::offset_y(@angle, 15)
    return false if @x.abs  > 640 && @y.abs > 480
    return hit_stars(stars, player)
  end
  
  def hit_stars(stars, player)
    !stars.reject! do |star|
      if Gosu::distance(@x, @y, star.x, star.y) < 15
        player.hit
        true
      else
        false
      end
    end
  end
  
  def init_sound
    @@sound = Gosu::Sample.new(@window, "media/laser.wav") unless @@sound
  end
end