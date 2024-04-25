# frozen-string-literal: true

# Node class to represent each square on the chessboard.
class Node
  attr_accessor :value, :parent, :children

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end
end

# Knight class to represent the knight.
# This class contains the binary search tree and methods for generating possible moves.
# Performing a breadth-first search (BFS) on the tree will give the shortest path to the target square.
class Knight
  attr_accessor :root

  def initialize(start)
    @root = Node.new(start)
  end

  # Method to generate possible moves for the knight.
  # The knight can move in an L-shape, two squares in one direction and one square in the other.
  def generate_moves(node)
    moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    valid_moves = []

    moves.each do |move|
      new_position = [node.value[0] + move[0], node.value[1] + move[1]]
      next unless new_position.all? { |coord| coord.between?(0, 7) }

      child = Node.new(new_position, node)
      node.children << child
      valid_moves << child
    end

    valid_moves
  end

  # Method to perform a breadth-first search on the tree.
  # This will give the shortest path to the target square.
  # Once found, return the path from the start position to the target position
  # by traversing up the BST from the target node to the root node.
  def bfs(target)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target

      queue.concat(generate_moves(current_node))
    end
  end

  # Method to find the shortest path from the starting square to the target square.
  def find_path(target)
    target_node = bfs(target)
    path = []

    until target_node.nil?
      path.unshift(target_node.value)
      target_node = target_node.parent
    end

    path
  end
end
