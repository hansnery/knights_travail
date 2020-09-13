# frozen_string_literal: true

# :nodoc:
class KnightsTravail
  require_relative 'lib/board'
  require_relative 'lib/knight'
  require_relative 'lib/board_methods'
  include BoardMethods

  def initialize(initial_longitude = 1, initial_latitude = 4)
    welcome
    @board = Board.new
    @knight = Knight.new(initial_longitude, initial_latitude)
    position_piece(@knight)
    @board.print_board
    ask_input
  end

  def welcome
    puts "\nWelcome to the Knight's Travail!\n\nIn this program you can calculate the shortest "
    puts 'amount of moves necessary to move the knight to a certain position on the board.'
    puts "\nType in the knight's destination using algebraic notation (eg: b3)."
  end

  def ask_input
    puts 'MOVE TO: '
    input = gets.chomp
    @longitude = letter_to_longitude(input[0])
    @latitude = input[1].to_i
    check_input(input)
  end

  def check_input(input)
    case input
    when /^[a-hA-H]{1}[1-8]/
      set_target(@longitude, @latitude)
      # @board.move_piece(@longitude, @latitude)
    else
      puts 'Wrong input! Try again!'
      ask_input
    end
  end

  def search_route
    while @target.visited == false
      @piece.possible_moves.each do |move|
        break if @target.visited == true

        new_longitude = @piece.longitude + move[0]
        new_latitude = @piece.latitude + move[1]
        next_tile = find_tile(new_longitude, new_latitude)

        next unless valid_move?(new_longitude, new_latitude) && next_tile.visited == false

        update_position(new_longitude, new_latitude)
      end
    end
    # display_rows
  end
end

KnightsTravail.new
