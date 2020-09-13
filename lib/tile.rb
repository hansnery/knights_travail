# frozen_string_literal: true

# :nodoc:
class Tile
  attr_accessor :data, :visited, :parent, :x_coordinate, :y_coordinate

  def initialize(data = '  ', visited = false, parent = nil, x_coordinate = nil, y_coordinate = nil)
    @data = data
    @visited = visited
    @parent = parent
    @x_coordinate = x_coordinate
    @y_coordinate = y_coordinate
  end
end
