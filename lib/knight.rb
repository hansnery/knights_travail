# frozen_string_literal: true

# :nodoc:
class Knight
  attr_accessor :longitude, :latitude
  attr_reader :data, :possible_longitudinal_moves, :possible_latitudinal_moves

  def initialize(longitude, latitude)
    @longitude = longitude
    @latitude = latitude
    @data = '♘ '
    @possible_longitudinal_moves = [2, 2, -2, -2, 1, 1, -1, -1]
    @possible_latitudinal_moves = [1, -1, 1, -1, 2, -2, 2, -2]
  end
end
