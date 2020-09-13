# frozen_string_literal: true

# :nodoc:
class Board
  require_relative 'tile'
  require 'colorize'

  attr_accessor :board, :target

  def initialize(size = 8, temp = [])
    @board_letters = ('a'..'h').to_a
    @columns = []
    size.times do
      size.times do
        temp << Tile.new
      end
      @columns << temp
      temp = []
    end
    @rows = @columns.transpose
    create_board_coordinates
  end

  def print_board(pos = 8)
    puts "\n"
    @rows.each_with_index do |sub_array, idx|
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

  def create_board_coordinates
    j = 8
    @rows.each do |row|
      i = 0
      row.each do |el|
        el.x_coordinate = @board_letters[i]
        el.y_coordinate = j
        i += 1
      end
      j -= 1
    end
  end

  def position_piece(piece)
    @piece = piece
    @rows[8 - @piece.latitude][@piece.longitude - 1].data = @piece.data
    @rows[8 - @piece.latitude][@piece.longitude - 1].visited = true
  end

  def set_target(longitude, latitude)
    @root = [@piece.longitude, @piece.latitude]
    @target = @rows[8 - latitude][longitude - 1]
    @target_coordinate = target_coordinate(longitude, latitude)
    @current_tile = @rows[8 - @piece.latitude][@piece.longitude - 1]
    puts "Target Coordinate: #{@target_coordinate}"
    search_route
  end

  def move_piece(new_longitude, new_latitude)
    empty_tile
    @piece.longitude = new_longitude
    @piece.latitude = new_latitude
    p @piece
    update_position(@piece.longitude, @piece.latitude)
  end

  def target_coordinate(longitude, latitude, distance = [])
    distance << longitude
    distance << latitude
    distance
  end

  def target_distance
    result = []
    @piece_coordinate = []
    @piece_coordinate << @piece.longitude
    @piece_coordinate << @piece.latitude
    result << @target_coordinate[0] - @piece_coordinate[0]
    result << @target_coordinate[1] - @piece_coordinate[1]
    result
  end

  def target_reached?
    return true if @piece.longitude == @target_coordinate[0] && @piece.latitude == @target_coordinate[1]
  end

  def empty_tile
    @rows[8 - @piece.latitude][@piece.longitude - 1].data = '  '
  end

  def update_position(longitude, latitude)
    # puts "Target Coordinate: #{@target_coordinate}"
    puts "Target Distance: #{target_distance}"
    puts "- Knight\nLongitude: #{@piece.longitude}\nLatitude: #{@piece.latitude}"
    # empty_tile
    @piece.longitude = longitude
    @piece.latitude = latitude
    @rows[8 - latitude][longitude - 1].data = @piece.data
    @rows[8 - latitude][longitude - 1].visited = true
    @rows[8 - latitude][longitude - 1].parent = @piece
    print_board
  end

  def valid_move?(new_longitude, new_latitude)
    return false if new_longitude > 8 || new_longitude < 1 || new_latitude > 8 || new_latitude < 1

    @piece.possible_moves.each do |move|
      return true if move[0] == (new_longitude - @piece.longitude) && move[1] == (new_latitude - @piece.latitude)
    end
    false
  end

  # def letter_to_number(letter)
  #   @board_letters.each_with_index do |board_letter, index|
  #     return index + 1 if board_letter == letter
  #   end
  # end

  def number_to_letter(number)
    @board_letters.each_with_index do |board_letter, index|
      return board_letter if number - 1 == index
    end
  end

  def find_tile(longitude, latitude)
    @rows.each do |row|
      row.each do |el|
        return el if el.x_coordinate == number_to_letter(longitude) && el.y_coordinate == latitude
      end
    end
  end

  def display_rows
    @rows.each do |row|
      row.each do |el|
        p el
      end
    end
  end

  def search_route
    # display_rows
    while @target.visited == false
      @piece.possible_moves.each do |move|
        break if @target.visited == true

        new_longitude = @piece.longitude + move[0]
        new_latitude = @piece.latitude + move[1]
        next_tile = find_tile(new_longitude, new_latitude)

        if valid_move?(new_longitude, new_latitude) && next_tile.visited == false
          p next_tile
          update_position(new_longitude, new_latitude)
        else
          @piece.longitude = @root[0]
          @piece.latitude = @root[1]
          # p @piece
          # search_route
          # display_rows
          # puts 'Done!'
        end
      end
      # update_position(@piece.longitude, @piece.latitude)
    end
    # display_rows
  end
end
