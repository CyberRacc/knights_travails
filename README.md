# Knights Travails | The Odin Project

## Explanation & Breakdown

### The `Node` Class

```ruby
class Node
  attr_accessor :value, :parent, :children

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end
end
```

- **Purpose**: Represents each square on the chessboard.
- **Attributes**:
  - `value`: Stores the coordinates of this node (or square) on the chessboard.
  - `parent`: References the node from which this node was reached. This is critical for retracing the path once the target is found.
  - `children`: An array of nodes that can be reached from this node using valid knight moves.

### The `Knight` Class

```ruby
class Knight
  attr_accessor :root

  def initialize(start)
    @root = Node.new(start)
  end
```

- **Purpose**: Manages the chessboard and the knight's moves.
- **Attributes**:
  - `root`: The starting position of the knight on the chessboard, represented as a node.

#### Method: `generate_moves`

```ruby
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
```

- **Purpose**: Generates all valid moves from the current position of the knight.
- **Logic**:
  - `moves`: Lists all possible L-shaped moves a knight can make.
  - It then checks each potential move to ensure it stays within the bounds of an 8x8 chessboard (`between?(0, 7)`).
  - Valid moves are instantiated as new nodes (children), linking back to the current node (`parent`).

#### Method: `bfs`

```ruby
  def bfs(target)
    queue = [root]

    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target

      queue.concat(generate_moves(current_node))
    end
  end
```

- **Purpose**: Performs a breadth-first search to find the shortest path to the target.
- **Logic**:
  - Starts with the root node and explores all neighbors first before moving on to next-level neighbors, ensuring the shortest path is found due to the level-wise exploration.
  - Nodes are added to the queue only after generating their possible moves, ensuring all possible paths are considered.

#### Method: `find_path`

```ruby
  def find_path(target)
    target_node = bfs(target)
    path = []

    until target_node.nil?
      path.unshift(target_node.value)
      target_node = target_node.parent
    end

    path
  end
```

- **Purpose**: Retrieves the full path from start to target by backtracking from the target node to the start node using the `parent` attribute.
- **Logic**:
  - Begins at the target and prepends each node's value to the path array until the start node (root) is reached (where `parent` is `nil`).

### The `knight_moves` Method

```ruby
def knight_moves(start, target)
  knight = Knight.new(start)
  path = knight.find_path(target)
  moves_count = path.length - 1
  move_label = moves_count == 1 ? "move" : "moves"
  puts "You made it in #{moves_count} #{move_label}! Here's your path:"
  path.each { |square| puts "  #{square}" }
end
```

- **Purpose**: Initializes the problem and prints the solution path.
- **Logic**:
  - Initializes a `Knight` instance with the start position.
  - Finds the shortest path using `find_path`.
  - Outputs the path and number of moves required.
