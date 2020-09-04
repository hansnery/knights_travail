# frozen_string_literal: true

# :nodoc:
class Board
  require_relative 'tile'
  require 'colorize'

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
    print_board
  end

  def print_board(pos = 8)
    @columns.each_with_index do |sub_array, idx|
      sub_array.each_with_index do |_, index|
        print_black_and_white(sub_array, idx, index)
        if index == 7
          puts "|#{pos}\n"
          pos -= 1
        end
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

  def knight_position(width, height)
    @columns[height][width].data = '♘ '
    puts "\n"
    print_board
  end
end

# Board.new
board = Board.new
board.knight_position(0, 0)
