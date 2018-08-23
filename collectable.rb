require 'gosu'
require_relative "./base_image.rb"

class Diamond < FallingObject
	def initialize(x, y)
		super("./images/diamond.png", x, y, 5)
	end

	def move
		super
		@y += @@velocity * 0.5
	end
end

class Gold < FallingObject
	def initialize(x, y)
		super("./images/gold.png", x, y, 1)
	end
end
