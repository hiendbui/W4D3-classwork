require_relative "piece.rb"
require_relative "rook_bishop_queen"
require_relative "knight_king"
require_relative "pawn"
require 'Singleton'

class Board
    def initialize
        @board = Array.new(8) {Array.new(8, nil)}
        self.pieces
    
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @board[row][col] = val
    end

    def move_piece(color, start_pos, end_pos)
        raise "invalid move" if self[start_pos].nil? || !self[end_pos].nil?

        self[end_pos] = self[start_pos]
        self[start_pos] = nil
    end

    def pieces
        (0..7).each do |col|
            case col
            when 0, 7
                self[0, col] = Rook.new(:black, self, [0,col])
                self[7, col] = Rook.new(:white, self, [0,col])
            when 1, 6
                self[0, col] = Knight.new(:black, self, [0,col])
                self[7, col] = Knight.new(:white, self, [0,col])                
            when 2, 5
                self[0, col] = Bishop.new(:black, self, [0,col])
                self[7, col] = Bishop.new(:white, self, [0,col])
            when 3
                self[0, col] = Queen.new(:black, self, [0,col])
                self[7, col] = Queen.new(:white, self, [0,col])
            when 4
                self[0, col] = King.new(:black, self, [0,col])
                self[7, col] = King.new(:white, self, [0,col])
            end
        end

        @board[1].each_with_index { |ele, i| @board[1, i] = Pawn.new(:black, self, [1, i]) }
        @board[6].each_with_index { |ele, i| @board[6, i] = Pawn.new(:white, self, [6, i]) }

        (2..5).each do |row|
            @board[row].map! {|ele| @sentinel}
        end

    end

    private
    def sentinel
        @sentinel = NullPiece.instance
    end
end

