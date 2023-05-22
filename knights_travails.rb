require_relative "tree_node"

class KnightPathFinder

    attr_accessor :start_pos, :considered_positions, :root_node

    def initialize(start_pos)
        @start_pos = start_pos
        @parent = []
        @considered_positions = [start_pos]
    end

    def self.root_node
        @root_node = PolyTreeNode.new(start_pos)
    end

    def build_move_tree(self.root_node)
        (0...8).each do |row_i|
            (0...8).each do |col_i|
                if self.valid_moves([row_i,col_i]) && !root_node.children.include?(pos)
                root_node.children << [row_i, col_i]
                root_node = [row_i, col_i]
                end
            end
        end
        
    end

    def self.valid_moves(pos)
            root_x , root_y = start_pos[0] , start_pos[1]
            x, y = pos[0], pos[1]
            unless (0..7).include?(x) && (0..7).include?(y)
                return false
            end 
            if x-(root_x) == abs(1) && y-(root_y) == abs(2)
                return true 
            elsif   
                x-(root_x) == abs(2) && y-(root_y) == abs(1)
                return true
            else 
                return false 
            end 
    end

    def new_move_positions(pos)
        unless considered_positions.include?(pos)
            @considered_positions << pos if KnightPathFinder.valid_moves(pos)
            return pos
        end 
    end 






end