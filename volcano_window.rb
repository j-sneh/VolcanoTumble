require 'gosu'
require_relative 'miner.rb'
require_relative 'score.rb'
require_relative 'collectable.rb'
require_relative 'lava.rb'
require_relative 'objects.rb'

class VolcanoWindow < Gosu::Window

WIDTH, HEIGHT = 800, 600

	def initialize
		super(WIDTH, HEIGHT)
		self.caption = "Volcano Tumble!"
		#@file = File.new("highscore.txt", "r+")
		@miner = Miner.new(400, 300)
		@score = Score.new
		@objects = FallingObjects.new(self)
		@game_over = false
		@high_score = 0
		@losing_text = GameOver.new(@score.score, @high_score, self)
		@lava = Gosu::Image.new("./images/lava.png")
	end
	
	def draw
		if !@game_over
			@lava.draw(0, 0, -10)
			@miner.draw
			@score.draw
			@objects.draw
			@score.draw
			Gosu.draw_rect(0, 600, WIDTH, HEIGHT / 3, Gosu::Color::RED)
		else
			@losing_text.draw
		end
	end

	def update
		if !@game_over
			ingame_update
		else
			gameover_update
		end
	end
	
	private

	def collision?(object)
		distance_apart = Gosu.distance(@miner.x, @miner.y, object.x, object.y)
		threshold = (@miner.width / 2) + (object.width / 2)
		return distance_apart <= threshold
	end

	def on_collision(object)
		@game_over = object.on_collision(@score)
		@objects.delete(object)
	end

	def reset
		@score.reset
		@objects.reset
		FallingObject.reset
		@miner = Miner.new(400, 300)
		@game_over = false
	end

	def ingame_update
		FallingObject.velocity = FallingObject::INITIAL_VELOCITY + (@score.score / 10)
		@objects.time_value = FallingObjects::START_TIME - (@score.score / 10)
		@miner.move
		@objects.generate
		@objects.move
		@objects.each { |object| on_collision(object) if collision?(object)}
		@game_over = true if offscreen?
	end

	def gameover_update
		@high_score = @high_score > @score.score ? @high_score : @score.score
		@losing_text = GameOver.new(@score.score, @high_score, self)
		reset if Gosu.button_down?(Gosu::KB_P)
		Kernel.exit if Gosu.button_down?(Gosu::KB_Q)
	end

	def offscreen?
		@miner.x + @miner.x_offset <= 0 || @miner.x - @miner.x_offset >= WIDTH || @miner.y + @miner.y_offset <= 0 || @miner.y - @miner.y_offset >= HEIGHT
	end
end
