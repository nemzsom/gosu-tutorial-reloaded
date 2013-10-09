require 'gosu'
require './zorder'
require './player'
require './star'

class GameWindow < Gosu::Window

  def initialize
    super 640, 480, false
    self.caption = "Gosu Tutorial Game"
    @background_image = Gosu::Image.new(self, "media/Space.png", true)
    @player = Player.new(self)
    @player.warp(320, 240)
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @stars = []
    @shots = []    
  end
  
  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
      @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight
      @player.turn_right
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0
      @player.accelerate
    end
    if button_down? Gosu::KbSpace
      @player.shoot(@shots)
    end
    @player.move
    @shots.select! { |shot| shot.move(@stars, @player) }
    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Star.new(self))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }
    @shots.each { |shot| shot.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
  
  def needs_cursor?
    false
  end
end

window = GameWindow.new
window.show