require_relative "tree_node"

class KnightPathFinder

    attr_accessor :start_pos, :considered_positions

    def initialize(start_pos)
        @start_pos = start_pos
        @parent = self.build_move_tree
        @considered_positions = [start_pos]
    end

    def self.root_node
        @root_node = PolyTreeNode.new(start_pos)
    end

    def build_move_tree(pos)
        @root_node.children << valid_moves
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
    end

    def new_move_positions(pos)
        unless considered_positions.include?(pos)
            @considered_positions << pos if KnightPathFinder.valid_moves(pos)
            return pos
        end 
    end 






end