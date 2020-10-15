require_relative "piece"

class Pawn < Piece
    def symbol
        @symbol = :pawn
    end

    def moves
        possible_moves = []
        row , col = @pos

        side_attacks.each do |side_attack|
            dx , dy = side_attack
            if !@board[[row + dx, col + dy]].nil? && @board[[row + dx, col + dy]].color != self.color
                possible_moves << [row + dx, col + dy]
            end
        end

        forward_steps.times do 
            possible_moves << [row += forward_dir, col] if !row.negative? && row < 8
        end

        possible_moves
    end

    private
    def forward_dir
        if @color == :black
            1
        else
            -1
        end
    end

    def forward_steps
        if @pos[0] == 1 || @pos[0] == 6
            2
        else
            1
        end
    end

    def side_attacks
        if @color == :black
            [[1, -1], [1, 1]]
        else
            [[-1, -1], [-1, 1]]
        end
    end
end
