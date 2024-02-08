require_relative './node'

class LinkedList
  attr_accessor :root

  def initialize(coord)
    @root = Node.new(coord)
  end
end
