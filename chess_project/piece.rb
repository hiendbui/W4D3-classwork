require_relative "board"
# require_relative "rook_bishop_queen"
# require_relative "knight_king"
# require_relative "pawn"
# require 'Singleton'

class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    def to_s
        self.class
    end

    def empty?
        self.is_a?(NullPiece)
    end

    def pos=(val)
        @pos = val
    end

    def symbol
        self.symbol
    end

   private

   def move_into_check(end_pos)
       
   end
end

class NullPiece < Piece
    
    include Singleton

    attr_reader :symbol

    def initialize
        @symbol = :NullPiece
    end

    def moves
        []
    end
end
