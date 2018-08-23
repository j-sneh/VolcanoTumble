require 'gosu'

class Score < Gosu::Font
	attr_reader :score

	def initialize
		super(50)
		@score = 0
	end

	def draw
		super(@score.to_s, 700, 10, 3)
	end

	def add_points(points)
		@score += points
	end

	def reset
		@score = 0
	end
end

class GameOver 
	def initialize(score, high_score, window)
		@score = score
		@high_score = high_score
		@window = window
	end

	def draw
		Gosu::Font.new(50).draw("Game Over!", @window.width/2 - 200, @window.height/2, 5)
		Gosu::Font.new(50).draw("Score: #{@score}", @window.width/2 - 200, (@window.height/2 + 50), 5)
		Gosu::Font.new(50).draw("High Score: #{@high_score}", @window.width/2 - 200, (@window.height/2 + 100), 5)

		Gosu::Font.new(20).draw("Press P to Play Again and Press Q to Quit", @window.width/2 - 200, @window.height/2 + 200, 5)
	end
end