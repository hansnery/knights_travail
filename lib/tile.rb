# frozen_string_literal: true

# :nodoc:
class Tile
  attr_accessor :data, :visited

  def initialize(data = '  ', visited = false)
    @data = data
    @visited = visited
  end
end
