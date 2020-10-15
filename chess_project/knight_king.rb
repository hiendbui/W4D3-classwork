require_relative "piece"

module Stepable
    KNIGHT_DIRS = [
                    [-2, -1],
                    [-2,  1],
                    [-1, -2],
                    [-1,  2],
                    [ 1, -2],
                    [ 1,  2],
                    [ 2, -1],
                    [ 2,  1]
                  ]
    KING_DIRS =   [
                    [ 0, -1],
                    [ 0,  1],
                    [-1,  0],
                    [ 1,  0],
                    [-1, -1],
                    [ 1,  1],
                    [-1,  1]
                    [ 1, -1]  
                   ]

    def moves
        possible_moves = []

        row , col = @pos
        self.move_diffs.each do |move|
            i , j = move
            end_pos = [row + i, col + j]
            possible_moves << end_pos if board[end_pos].color != self.color
        end
        
        .reject {|move| move.any? {|coord| coord.negative? || coord > 7 } }

        possible_moves
    end
end

class Knight < Piece
    include Stepable

    def symbol
        @symbol = :knight
    end

    protected

    def move_diffs
        KNIGHT_DIRS
    end
end

class King < Piece
    include Stepable
    def symbol
        @symbol = :king
    end

    protected

    def move_diffs
        KING_DIRS
    end
end
