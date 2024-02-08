require_relative './linked_list'

class Knight
  def moves_list_from(coord)
    LinkedList.new(coord).root
  end

  def knight_moves(start_square, end_square, current = nil, queue = [moves_list_from(start_square)])
    return 'Error: off the board' if end_square.off? || start_square.off?
    return current if current&.square == end_square

    current = queue.shift
    current.next&.each { |el| queue << el}

    target_square = knight_moves(start_square, end_square, current, queue)
    return target_square if target_square.is_a?(Array)

    path = [target_square]
    path.unshift(path[0].previous) until path[0].previous.nil?
    path = path.map { |node| node.square }
  end
end
