require_relative './linked_list'

class Knight
  def moves_list_from(coord)
    LinkedList.new(coord).root
  end

  def knight_moves(start_sq, end_sq, current = nil, queue = [moves_list_from(start_sq)])
    return 'Error: off the board' if end_sq.off? || start_sq.off?
    return current if current&.square == end_sq

    current = queue.shift
    current.next&.each { |el| queue << el}

    target_sq = knight_moves(start_sq, end_sq, current, queue)
    return target_sq if target_sq.is_a?(Array)

    build_path_from(target_sq)
  end

  private

  def build_path_from(target_square)
    path = [target_square]
    path.unshift(path[0].previous) until path[0].previous.nil?
    path = path.map { |node| node.square }
    puts "You made it in #{path.size - 1} moves! Here's your path:"
    path.reverse.each { |el| p el }
  end
end
