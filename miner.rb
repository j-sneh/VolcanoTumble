require 'gosu'
require_relative './base_image.rb'

class Miner < BaseImage
	INITIAL_VELOCITY = 5
	
	def initialize(x, y)
		super('./images/head.png', x, y, 2)
	end

	def move
		@y += INITIAL_VELOCITY
		@y -= INITIAL_VELOCITY * 2 if Gosu.button_down?(Gosu::KB_UP) || Gosu.button_down?(Gosu::KB_W)
		@x += INITIAL_VELOCITY if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::KB_D)
		@x -= INITIAL_VELOCITY if Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::KB_A)
	end
end