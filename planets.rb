require "gosu"

class Planet

	attr_reader :x, :y, :vel_x, :vel_y, :mass, :image, :universe_radius, :planet_radius, :vel_z

	def initialize(x, y, vel_x, vel_y, mass, image, universe_radius, planet_radius, vel_z)
		@x = x
		@y = y
		@vel_x = vel_x
		@vel_y = vel_y
		@mass = mass
		@image = image
		@universe_radius = universe_radius
		@force_x = 0
		@force_y = 0
		@force_z = 0
		@planet_radius = planet_radius
		@z = 0
		@vel_z = vel_z
		@collision = false
		on_screen = true
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
	 	@force_z = 0
	end 

	def check_collisions(planet2)
		if @planet_radius + planet2.planet_radius > Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.y - @y)*(planet2.y - @y))
			@collision = true
		elsif @planet_radius + planet2.planet_radius > Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.z - @z)*(planet2.z - @z))
			@collision = true
		elsif @planet_radius + planet2.planet_radius > Math.sqrt((planet2.z - @z)*(planet2.z - @z) + (planet2.y - @y)*(planet2.y - @y))
			@collision = true
		end
	end

	def collide
		if collision = true
			@image.width = @image.width / 2
			@image.height = @image.height / 2
			# create another planet
			# send planets in a random direction
		end
	end

	def force_z(planet2)
		distance = Math.sqrt((planet2.x - @x)*(planet2.x - @x) + (planet2.z - @z)*(planet2.z - @z))
		force = GRAVITY_CONSTANT * (planet2.mass * @mass) / ((distance)*(distance))
		@force_z += force * ((planet2.z - @z) / distance)
	end

	def planet_size
		accel_z = @force_z / @mass
		@vel_z += accel_z * TIME
		@z += @vel_z * TIME

		if vel_z < 0
			@image.width = @image.width * 0.2
			@image.height = @image.height * 0.2
		elsif vel_z > 0
			@image.width = @image.width * 5
			@image.height = @image.height * 5
		end
 
		if @z > universe_radius
			on_screen = false
		end
	end

	def draw()
		if on_screen = true
			x_coor = ((@x / @universe_radius) * 320) + 320 - (@image.width/2)
			y_coor = ((-@y / @universe_radius) * 320) + 320 - (@image.height/2)
			@image.draw(x_coor, y_coor, 0)
		end
	end

end