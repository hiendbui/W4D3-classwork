require_relative "piece"

module Slideable

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        possible_moves = []

        self.move_dirs.each do |dir|
            dx , dy = dir
            possible_moves += grow_unblocked_moves_in_dir(dx, dy)
        end

        possible_moves
    end

    private
    HORIZONTAL_DIRS = [
                       [ 0,  1],
                       [ 0, -1],
                       [-1,  0],
                       [ 1,  0]
                      ]
    DIAGONAL_DIRS =   [
                       [ 1,  1], 
                       [-1, -1], 
                       [ 1, -1], 
                       [-1,  1]
                      ]

    def grow_unblocked_moves_in_dir(dx, dy)
        possible_moves = []
        blocked = false
        
        x , y = self.pos
        i, j = dx , dy
        until blocked 
            end_pos = [x + i, y + j]
            if end_pos.any? {|coord| coord.negative? || coord > 7 }
                blocked = true
            elsif @board[end_pos].nil?
                possible_moves << end_pos
            else
                possible_moves << end_pos if @board[end_pos].color != self.color
                blocked = true
            end
            i += dx
            j += dy
        end
        possible_moves
    end

end

class Rook < Piece
    include Slideable

    def move_dirs
        horizontal_dirs
    end
end

class Bishop < Piece
    include Slideable

    def move_dirs
        diagonal_dirs
    end
end

class Queen < Piece
    include Slideable

    def move_dirs
        horizontal_dirs + diagonal_dirs
    end
end