# frozen_string_literal: true

# :nodoc:
class Board
  require_relative 'tile'
  require 'colorize'

  def initialize(size = 8)
    @board = []
    (size * size).times do
      @board << Tile.new
    end
    print_board
  end

  def print_board(pos = 1)
    @board.each_with_index do |_, index|
      if white_tile?(index)
        print to_white_background(@board[index])
      else
        print to_black_background(@board[index])
      end
      puts "|#{pos}\n" if breakline?(index)
      pos += 1 if breakline?(index)
    end
    puts 'a b c d e f g h'
  end

  def breakline?(index)
    breaklines = [7, 15, 23, 31, 39, 47, 55, 63]
    return true if breaklines.include?(index)
  end

  def white_tile?(index)
    white_tiles = [0, 2, 4, 6, 9, 11, 13, 15, 16, 18, 20,
                   22, 25, 27, 29, 31, 32, 34, 36, 38, 41,
                   43, 45, 47, 48, 50, 52, 54, 57, 59, 61, 63]
    return true if white_tiles.include?(index)
  end

  def to_white_background(string)
    string.data.colorize(color: :black, background: :white)
  end

  def to_black_background(string)
    string.data.colorize(color: :white, background: :black)
  end

  def modify_array(index)
    @board[index].data = '♘ '
    puts "\n"
    print_board
  end
end

# Board.new
board = Board.new
board.modify_array(21)
