# frozen_string_literal: true

# :nodoc:
class Board
  require_relative 'tile'
  require 'colorize'

  attr_accessor :columns

  def initialize(size = 8, temp = [])
    @board = []
    size.times do
      size.times do
        temp << Tile.new
      end
      @board << temp
      temp = []
    end
    @columns = @board.transpose
  end

  def print_board(pos = 8)
    puts "\n"
    @columns.each_with_index do |sub_array, idx|
      sub_array.each_with_index do |_, index|
        print_black_and_white(sub_array, idx, index)
        puts "|#{pos}\n" if index == 7
        pos -= 1 if index == 7
      end
    end
    puts 'a b c d e f g h'
  end

  def print_black_and_white(sub_array, idx, index)
    print to_black_background(sub_array[index]) if idx.odd? && index.even?
    print to_white_background(sub_array[index]) if idx.odd? && index.odd? || idx.even? && index.even?
    print to_black_background(sub_array[index]) if idx.even? && index.odd?
  end

  def breakline?(index)
    breaklines = [7, 15, 23, 31, 39, 47, 55, 63]
    return true if breaklines.include?(index)
  end

  def white_tile?(index)
    white_tiles = [0, 2, 4, 6]
    return true if white_tiles.include?(index)
  end

  def to_white_background(string)
    string.data.colorize(color: :black, background: :white)
  end

  def to_black_background(string)
    string.data.colorize(color: :white, background: :black)
  end

  def position_piece(piece)
    @piece = piece
    @columns[8 - @piece.latitude][@piece.longitude - 1].data = @piece.data
  end

  def move_piece(new_longitude, new_latitude)
    empty_tile
    @piece.longitude = new_longitude
    @piece.latitude = new_latitude
    # p @piece
    update_position(@piece.longitude, @piece.latitude)
    print_board
  end

  def empty_tile
    @columns[8 - @piece.latitude][@piece.longitude - 1].data = '  '
  end

  def update_position(longitude, latitude)
    @columns[8 - latitude][longitude - 1].data = @piece.data
  end

  def valid_move?(new_longitude, new_latitude)
    @piece.possible_moves.each do |move|
      return true if move[0] == (new_longitude - @piece.longitude) && move[1] == (new_latitude - @piece.latitude)
    end
    false
  end
end
