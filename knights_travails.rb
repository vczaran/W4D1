require_relative "tree_node"

class KnightPathFinder

    attr_accessor :start_pos

    def initialize(start_pos)
        @start_pos = start_pos
        @parent = self.build_move_tree
       
    end

    def self.root_node
        @root_node = PolyTreeNode.new(start_pos)
    end

    def build_move_tree
        @root_node.children << valid_moves
    end

    def self.valid_moves(pos)
    end








end