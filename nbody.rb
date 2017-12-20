require "gosu"
require_relative "z_order"
require "./planets"

class NbodySimulation < Gosu::Window

  def initialize()
    super(640, 640, false)
    self.caption = "NBody simulation"
    @background_image = Gosu::Image.new("images/space.jpg", tileable: true)
    @planet_list = []
    planets_recorded = 0
    input = ARGV
    filename = input[0]
    File.open("simulations/#{filename}").each_with_index do |line, i|
      info = line.split(" ")
      if i == 0 
        number_of_bodies = info[0].to_f
      end
      if i == 1 
        @universe_radius = line.to_f
      end 
      if info[0] == nil || planets_recorded == number_of_bodies
        break
      end
      if i > 1
          planet = Planet.new(info[0].to_f, info[1].to_f, info[2].to_f, info[3].to_f, info[4].to_f, Gosu::Image.new("images/#{info[5]}"), @universe_radius, info[6].to_f, info[7].to_f)
          @planet_list.push(planet)
          planets_recorded += 1
      end
    end
  end

  def update
    @planet_list.each do |planet1|
      @planet_list.each do |planet2|
        if planet1 != planet2
          planet1.force_x(planet2)
          planet1.force_y(planet2)
          planet1.force_z(planet2)
          planet1.check_collisions(planet2)
        end
      end
      planet1.acceleration_x()
      planet1.acceleration_y()
      planet1.collide()
      planet1.planet_size()
      planet1.reset_forces()
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @planet_list.each do |planet|
      planet.draw
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
  
end

window = NbodySimulation.new
window.show