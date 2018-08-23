require_relative 'collectable.rb'
require_relative 'lava.rb'

class FallingObjects
	include Enumerable

	attr_reader :objects
	attr_writer :time_value

	START_TIME = 30

	def initialize(window)
		@objects = []
		@timer = START_TIME
		@time_value = START_TIME
		@window = window
	end

	def generate
		@timer -= 1
		if @timer <= 0
			add
			@timer = @time_value
		end
	end

	def delete(object)
		self.objects.delete(object)
	end

	def move
		garbage_collection
		self.each {|object| object.move }
	end

	def draw
		self.each {|object| object.draw }
	end

	def reset
		@objects = []
	end
	# IMPLEMENT ENUMERABLE

	def each
		self.objects.each {|object| yield(object)}
	end

	private

	def add
		chance = rand(1..10)
		@objects << Lava.new(rand(0..@window.width), 0) unless rand(1..5) == 2
		@objects << (chance <= 9 ? Gold.new(rand(0..@window.width), 0) : Diamond.new(rand(0..@window.width), 0))
	end

	def garbage_collection
		self.objects.delete_if {|object| object.y >= @window.height}
	end
end