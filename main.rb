# frozen_string_literal: true

# :nodoc:
class KnightsTravail
  require_relative 'lib/board'
  require_relative 'lib/knight'

  def initialize(longitude = 1, latitude = 1)
    welcome
    @board = Board.new
    @board.position_piece(Knight.new(longitude, latitude))
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
    check_input(input)
  end

  def check_input(input)
    case input
    when /^[a-hA-H]{1}[1-8]/
      if @board.valid_move?(letter_to_longitude(input[0]), input[1].to_i)
        @board.move_piece(letter_to_longitude(input[0]), input[1].to_i)
      else
        puts 'Wrong input! Try again!'
        ask_input
      end
    end
  end

  def letter_to_longitude(input_letter)
    board_letters = ('a'..'h').to_a
    board_letters.each_with_index do |board_letter, index|
      return index + 1 if input_letter == board_letter
    end
  end
end

KnightsTravail.new
