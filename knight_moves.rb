# frozen-string-literal: true

require_relative 'lib/knights_travails'

def knight_moves(start, target)
  knight = Knight.new(start)
  path = knight.find_path(target)
  puts "You made it in #{path.length - 1} moves! Here's your path:" unless (path.length - 1) == 1
  puts "You made it in #{path.length - 1} move! Here's your path:" if (path.length - 1) == 1
  path.each { |square| puts "  #{square}" }
end

knight_moves([0, 0], [7, 7])
knight_moves([0, 0], [1, 2])
knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
knight_moves([3, 3], [4, 3])
