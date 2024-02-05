require_relative './linked_list'

class Knight
  MOVES = LinkedList.new.root

  def knight_moves(start_square, end_square, current = nil, queue = [MOVES])
    return 'Error: off the board' unless end_square.not_off? || start_square.not_off?
    return current if current&.square == end_square || queue.empty?

    current = queue.shift

    current.next&.each { |el| queue << el}

    most_close_parent = knight_moves(start_square, end_square, current, queue)
    return most_close_parent if most_close_parent.is_a?(Array)

    path = [most_close_parent]
    path.unshift(path[0].previous) until path[0].previous.nil?
    path = path.map { |node| node.square }
  end
end
