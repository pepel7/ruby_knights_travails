require_relative './node'

class LinkedList
  attr_accessor :root

  def initialize
    @root = Node.new([0, 0])
  end
end
