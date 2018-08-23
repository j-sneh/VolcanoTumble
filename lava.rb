require 'Gosu'
require_relative 'base_image.rb'

class Lava < FallingObject
	def initialize(x, y)
		super("./images/fire.png", x, y, 0)
	end

	def on_collision(score=nil)
		true
	end
end
