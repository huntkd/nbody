require "gosu"

class Planet

	attr_reader :x, :y, :vel_x, :vel_y, :mass, :image, :universe_radius

	def initialize(x, y, vel_x, vel_y, mass, image, universe_radius)
		@x = x
		@y = y
		@vel_x = vel_x
		@vel_y = vel_y
		@mass = mass
		@image = image
		@universe_radius = universe_radius
		@force_x = 0
		@force_y = 0
	end

	GRAVITY_CONSTANT = 6.67408e-11
	TIME = 25000

	def force_x(planet2)
		distance = Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
		force = GRAVITY_CONSTANT * (planet2.mass * @mass) / ((distance)*(distance))
		@force_x += force * ((planet2.x - @x) / distance)
	end

	def force_y(planet2)
		distance = Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
		force = GRAVITY_CONSTANT * (planet2.mass * @mass) / ((distance)*(distance))
		@force_y += force * ((planet2.y - @y) / distance)
	end

	def acceleration_x()
		accel_x = @force_x / @mass
		@vel_x += accel_x * TIME
		@x += @vel_x * TIME
	end

	def acceleration_y()
		accel_y = @force_y / @mass
		@vel_y += accel_y * TIME
		@y += @vel_y * TIME
	end

	def reset_forces
	 	@force_x = 0
	 	@force_y = 0
	end 

	def draw()
		x_coor = ((@x / @universe_radius) * 320) + 320 - (@image.width/2)
		y_coor = ((-@y / @universe_radius) * 320) + 320 - (@image.height/2)
		@image.draw(x_coor, y_coor, 0)
	end

end