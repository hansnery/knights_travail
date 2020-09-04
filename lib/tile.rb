# frozen_string_literal: true

# :nodoc:
class Tile
  attr_accessor :data

  def initialize(data = '  ')
    @data = data
  end
end
