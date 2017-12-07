require "gosu"

class Planet

	attr_reader :X, :y, :vel_x, :vel_y, :mass, :image, :universe_radius

	def initialize(x, y, vel_x, vel_y, mass, image, universe_radius)
		@x = x
		@y = y
		@vel_x = vel_x
		@vel_y = vel_y
		@mass = mass
		@image = image
		@universe_radius = universe_radius
	end

	def draw()
		x = ((@x/@universe_radius) * 320) + 320
		y = ((@y/@universe_radius) * 320) + 320
		image.draw(x, y, 0)
	end

	def force_x(planetx, planety, mass)
		
	end

	def force_y(planetx, planety, mass)
		
	end

end