require_relative "tree_node"

class KnightPathFinder

    attr_accessor :start_pos, :considered_positions, :root_node

    def initialize(start_pos)
        @start_pos = start_pos
        @parent = []
        @considered_positions = [start_pos]
        @root_node = PolyTreeNode.new(start_pos)
    end

    def build_move_tree
        queue = [self.root_node]
    
        until queue.empty?
            parent = queue.drop(1)
            new_nodes = new_move_positions(parent)
            
            queue.shift.children << new_move_positions(self.start_pos).shift
            root_node.children.each do |child|  
                build_move_tree(child)
            end 
        end 
    end

    def self.valid_moves(pos)
        valid_moves = []
            x, y = pos[0], pos[1]
            [1, -1].each do |ele1|
                [2, -2].each do |ele2|
                    valid_moves << [(x + ele1), (y + ele2)]
                    valid_moves << [(x + ele2), (y + ele1)]
                end 
            end 
          valid_moves.select do |newpos|
            (0..7).include?(newpos[0]) && (0..7).include?(newpos[1])
          end 
    end

    def new_move_positions(pos)
        return @considered_positions += KnightPathFinder.valid_moves(pos).select { |validpos| !considered_positions.include?(validpos)} 
    end 

end