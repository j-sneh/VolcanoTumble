require 'gosu'

class BaseImage < Gosu::Image

	attr_reader :x, :y, :z

	def initialize(source, x, y, z)
		super(source)
		@x, @y, @z = x, y, z
	end

	def draw
		super(@x - x_offset, @y - y_offset, @z)
	end

	def move
		nil
	end
	
	def x_offset
		self.width / 2
	end

	def y_offset
		self.height / 2
	end
	
end

class FallingObject < BaseImage

	INITIAL_VELOCITY = 2

	attr_reader :points

	def initialize(source, x, y, points)
		super(source, x, y, 1)
		@@velocity = INITIAL_VELOCITY
		@points = points
	end

	def move
		@y += @@velocity
	end

	def on_collision(score)
		score.add_points(self.points)
		return false
	end

	def self.reset
		@@velocity = INITIAL_VELOCITY
	end

	def self.velocity=(velocity)
		@@velocity = velocity
	end
end

