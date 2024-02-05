class Node
  attr_accessor :square, :next, :previous

  DIRECTIONS = [[+2, -1], [+1, -2], [-1, -2], [-2, -1],
                [+2, +1], [+1, +2], [-1, +2], [-2, +1]].freeze

  @@already_existing_squares = []

  def initialize(coord, previous = nil)
    @square = coord
    @next = @@already_existing_squares.count(coord) > 2 ? nil : calc_next(coord, self)
    @previous = previous
  end

  def calc_next(coord, parent)
    next_squares = []

    DIRECTIONS.each do |direction|
      possible_next_square = [(coord[0] + direction[0]), (coord[1] + direction[1])]
      if possible_next_square.not_off?
        next_squares << possible_next_square
        @@already_existing_squares << possible_next_square
      end
    end

    next_squares.map { |square_coord| Node.new(square_coord, parent) }
  end
end

class Array
  def not_off?
    self.all? { |coord| coord.between?(0, 7) }
  end
end

# p Node.new([0,0])
