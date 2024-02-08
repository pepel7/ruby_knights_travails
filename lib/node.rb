class Node
  attr_accessor :square, :next, :previous

  DIRECTIONS = [[+2, -1], [+1, -2], [-1, -2], [-2, -1],
                [+2, +1], [+1, +2], [-1, +2], [-2, +1]].freeze

  @@already_existing_in_path = []
  @@waiting_above = {}

  def initialize(coord, previous = nil)
    @square = coord
    @next = @@already_existing_in_path.include?(coord) ||
            @@waiting_above.include?(coord) ? nil : calc_next(coord, self)
    @previous = previous
  end

  def calc_next(coord, parent)
    next_squares = []

    DIRECTIONS.each do |direction|
      possible_next_square = [(coord[0] + direction[0]), (coord[1] + direction[1])]
      next_squares << possible_next_square unless possible_next_square.off?
    end

    temp_parent = parent
    until temp_parent.nil? 
      @@already_existing_in_path << temp_parent.square unless @@already_existing_in_path.include?(temp_parent.square)
      temp_parent = temp_parent.previous
    end

    next_squares.each do |sq|
      @@waiting_above[sq] = parent unless @@waiting_above.include?(sq) ||
                                          @@already_existing_in_path.include?(sq)
    end

    next_squares.map do |sq_coord|
      @@waiting_above.delete(sq_coord) if @@waiting_above[sq_coord] == parent
      Node.new(sq_coord, parent)
    end
  end
end

class Array
  def off?
    self.any? { |coord| !coord.between?(0, 7) }
  end
end

# p Node.new([0,0])
